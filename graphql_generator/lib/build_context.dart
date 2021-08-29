import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

class BuildContext {
  ReCase _modelClassNameRecase;
  TypeReference _modelClassType;

  /// A map of fields that are absolutely required, and error messages for when they are absent.
  final Map<String, String> requiredFields = {};

  /// A map of field names to resolved names from `@Alias()` declarations.
  final Map<String, String> aliases = {};

  /// A map of field names to their default values.
  final Map<String, DartObject> defaults = {};

  /// A map of fields to their related information.
  final Map<String, SerializableFieldMirror> fieldInfo = {};

  /// A map of fields that have been marked as to be excluded from serialization.
  // ignore: deprecated_member_use
  // final Map<String, Exclude> excluded = {};

  /// A map of "synthetic" fields, i.e. `id` and `created_at` injected automatically.
  final Map<String, bool> shimmed = {};

  final bool autoIdAndDateFields, autoSnakeCaseNames;

  final String originalClassName, sourceFilename;

  /// The fields declared on the original class.
  final List<FieldElement> fields = [];

  final List<ParameterElement> constructorParameters = [];

  final ConstantReader annotation;

  final ClassElement clazz;

  /// Any annotations to include in the generated class.
  final List<DartObject> includeAnnotations;

  /// The name of the field that identifies data of this model type.
  String primaryKeyName = 'id';

  BuildContext(this.annotation, this.clazz,
      {this.originalClassName,
      this.sourceFilename,
      this.autoSnakeCaseNames,
      this.autoIdAndDateFields,
      this.includeAnnotations = const <DartObject>[]});

  /// The name of the generated class.
  String get modelClassName => originalClassName.startsWith('_')
      ? originalClassName.substring(1)
      : originalClassName;

  /// A [ReCase] instance reflecting on the [modelClassName].
  ReCase get modelClassNameRecase =>
      _modelClassNameRecase ??= ReCase(modelClassName);

  TypeReference get modelClassType =>
      _modelClassType ??= TypeReference((b) => b.symbol = modelClassName);

  /// The [FieldElement] pointing to the primary key.
  FieldElement get primaryKeyField =>
      fields.firstWhere((f) => f.name == primaryKeyName);

  bool get importsPackageMeta {
    return clazz.library.imports.any((i) => i.uri == 'package:meta/meta.dart');
  }

  /// Get the aliased name (if one is defined) for a field.
  String resolveFieldName(String name) =>
      aliases.containsKey(name) ? aliases[name] : name;

  /// Finds the type that the field [name] should serialize to.
  DartType resolveSerializedFieldType(String name) {
    return fieldInfo[name]?.serializesTo ??
        fields.firstWhere((f) => f.name == name).type;
  }
}

class SerializableFieldMirror {
  final String alias;
  final DartObject defaultValue;
  final Symbol serializer, deserializer;
  final String errorMessage;
  final bool isNullable, canDeserialize, canSerialize, exclude;
  final DartType serializesTo;

  SerializableFieldMirror(
      {this.alias,
      this.defaultValue,
      this.serializer,
      this.deserializer,
      this.errorMessage,
      this.isNullable,
      this.canDeserialize,
      this.canSerialize,
      this.exclude,
      this.serializesTo});
}

final Map<String, BuildContext> _cache = {};

/// Create a [BuildContext].
Future<BuildContext> buildContext(
  ClassElement clazz,
  ConstantReader annotation,
  BuildStep buildStep,
  Resolver resolver,
  bool autoSnakeCaseNames, {
  bool heedExclude = true,
}) async {
  final id = clazz.location.components.join('-');
  if (_cache.containsKey(id)) {
    return _cache[id];
  }

  // Check for autoIdAndDateFields, autoSnakeCaseNames
  autoSnakeCaseNames =
      annotation.peek('autoSnakeCaseNames')?.boolValue ?? autoSnakeCaseNames;

  final ctx = BuildContext(
    annotation,
    clazz,
    originalClassName: clazz.name,
    sourceFilename: p.basename(buildStep.inputId.path),
    autoSnakeCaseNames: autoSnakeCaseNames,
    includeAnnotations:
        annotation.peek('includeAnnotations')?.listValue ?? <DartObject>[],
  );
  // var lib = await resolver.libraryFor(buildStep.inputId);
  final List<String> fieldNames = [];
  final fields = <FieldElement>[];

  // Crawl for classes from parent classes.
  void crawlClass(InterfaceType t) {
    while (t != null) {
      fields.insertAll(0, t.element.fields);
      t.interfaces.forEach(crawlClass);
      t = t.superclass;
    }
  }

  crawlClass(clazz.thisType);

  for (final field in fields) {
    // Skip private fields
    if (field.name.startsWith('_')) {
      continue;
    }

    if (field.getter != null &&
        (field.setter != null || field.getter.isAbstract)) {
      final el = field.setter == null ? field.getter : field;
      fieldNames.add(field.name);

      // Check for @SerializableField
      final fieldAnn = null; // TODO: serializableFieldTypeChecker.firstAnnotationOf(el);

      void handleSerializableField(SerializableFieldMirror sField) {
        ctx.fieldInfo[field.name] = sField;

        if (sField.defaultValue != null) {
          ctx.defaults[field.name] = sField.defaultValue;
        }

        if (sField.alias != null) {
          ctx.aliases[field.name] = sField.alias;
        } else if (autoSnakeCaseNames != false) {
          ctx.aliases[field.name] = ReCase(field.name).snakeCase;
        }

        if (sField.isNullable == false) {
          final reason = sField.errorMessage ??
              "Missing required field '${ctx.resolveFieldName(field.name)}' on ${ctx.modelClassName}.";
          ctx.requiredFields[field.name] = reason;
        }

        if (sField.exclude) {
          // ignore: deprecated_member_use
          // ctx.excluded[field.name] = Exclude(
          //   canSerialize: sField.canSerialize,
          //   canDeserialize: sField.canDeserialize,
          // );
        }
      }

      if (fieldAnn != null) {
        // var cr = ConstantReader(fieldAnn);
        // var excluded = cr.peek('exclude')?.boolValue ?? false;
        // var sField = SerializableFieldMirror(
        //   alias: cr.peek('alias')?.stringValue,
        //   defaultValue: cr.peek('defaultValue')?.objectValue,
        //   serializer: cr.peek('serializer')?.symbolValue,
        //   deserializer: cr.peek('deserializer')?.symbolValue,
        //   errorMessage: cr.peek('errorMessage')?.stringValue,
        //   isNullable: cr.peek('isNullable')?.boolValue ?? !excluded,
        //   canDeserialize: cr.peek('canDeserialize')?.boolValue ?? false,
        //   canSerialize: cr.peek('canSerialize')?.boolValue ?? false,
        //   exclude: excluded,
        //   serializesTo: cr.peek('serializesTo')?.typeValue,
        // );

        // handleSerializableField(sField);

        // Apply
      } else {
        final foundNone = true;

        // Check for @required
        // var required =
        //     const TypeChecker.fromRuntime(Required).firstAnnotationOf(el);

        // if (required != null) {
        //   log.warning(
        //       'Using @required on fields (like ${clazz.name}.${field.name}) is now deprecated; use @SerializableField(isNullable: false) instead.');
        //   var cr = ConstantReader(required);
        //   var reason = cr.peek('reason')?.stringValue ??
        //       "Missing required field '${ctx.resolveFieldName(field.name)}' on ${ctx.modelClassName}.";
        //   ctx.requiredFields[field.name] = reason;
        //   foundNone = false;
        // }

        // if (foundNone) {
        //   var f = SerializableField();
        //   var sField = SerializableFieldMirror(
        //     alias: f.alias,
        //     defaultValue: null,
        //     serializer: f.serializer,
        //     deserializer: f.deserializer,
        //     errorMessage: f.errorMessage,
        //     isNullable: f.isNullable,
        //     canDeserialize: f.canDeserialize,
        //     canSerialize: f.canSerialize,
        //     exclude: f.exclude,
        //     serializesTo: null,
        //   );
        //   handleSerializableField(sField);
        // }
      }

      ctx.fields.add(field);
    }
  }

  // Get constructor params, if any
  ctx.constructorParameters.addAll(clazz.unnamedConstructor.parameters);

  return ctx;
}

// Skip if annotated with @exclude
// var excludeAnnotation = excludeTypeChecker.firstAnnotationOf(el);

// if (excludeAnnotation != null) {
//   var cr = ConstantReader(excludeAnnotation);
//   foundNone = false;

//   // ignore: deprecated_member_use
//   ctx.excluded[field.name] = Exclude(
//     canSerialize: cr.read('canSerialize').boolValue,
//     canDeserialize: cr.read('canDeserialize').boolValue,
//   );
// }

// Check for @DefaultValue()
// var defAnn =
//     // ignore: deprecated_member_use
//     const TypeChecker.fromRuntime(DefaultValue).firstAnnotationOf(el);
// if (defAnn != null) {
//   var rev = ConstantReader(defAnn).revive().positionalArguments[0];
//   ctx.defaults[field.name] = rev;
//   foundNone = false;
// }

// Check for alias
// ignore: deprecated_member_use
// Alias alias;
// var aliasAnn = aliasTypeChecker.firstAnnotationOf(el);

// if (aliasAnn != null) {
//   // ignore: deprecated_member_use
//   alias = Alias(aliasAnn.getField('name').toStringValue());
//   foundNone = false;
// }

// if (alias?.name?.isNotEmpty == true) {
//   ctx.aliases[field.name] = alias.name;
// } else if (autoSnakeCaseNames != false) {
//   ctx.aliases[field.name] = ReCase(field.name).snakeCase;
// }