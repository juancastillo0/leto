// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<KeyedAttachment, Object?, Object?>
    get getKeyedAttachmentGraphQLField => _getKeyedAttachmentGraphQLField.value;
final _getKeyedAttachmentGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<KeyedAttachment, Object?, Object?>>(
    (setValue) => setValue(keyedAttachmentGraphQLType.nonNull().field<Object?>(
          'getKeyedAttachment',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getKeyedAttachment();
          },
        )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _keyedAttachmentGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<KeyedAttachment>>((setValue) {
  final __name = 'KeyedAttachment';

  final __keyedAttachmentGraphQLType = objectType<KeyedAttachment>(__name,
      isInterface: false,
      interfaces: [],
      extra: GraphQLTypeDefinitionExtra.attach([
        ...KeyedAttachment.attachments(),
      ]));

  setValue(__keyedAttachmentGraphQLType);
  __keyedAttachmentGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLDate.nonNull().field('createdAt',
          resolve: (obj, ctx) => obj.createdAt,
          attachments: [
            ValidaAttachment(ValidaDate(max: 'now')),
          ]),
      nestedAttachmentGraphQLType
          .nonNull()
          .field('nested', resolve: (obj, ctx) => obj.nested)
    ],
  );

  return __keyedAttachmentGraphQLType;
});

/// Auto-generated from [KeyedAttachment].
GraphQLObjectType<KeyedAttachment> get keyedAttachmentGraphQLType =>
    _keyedAttachmentGraphQLType.value;

final _nestedAttachmentGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NestedAttachment>>((setValue) {
  final __name = 'NestedAttachment';

  final __nestedAttachmentGraphQLType = objectType<NestedAttachment>(__name,
      isInterface: false,
      interfaces: [],
      extra: GraphQLTypeDefinitionExtra.attach([
        ...NestedAttachment.attachments(),
      ]));

  setValue(__nestedAttachmentGraphQLType);
  __nestedAttachmentGraphQLType.fields.addAll(
    [graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id)],
  );

  return __nestedAttachmentGraphQLType;
});

/// Auto-generated from [NestedAttachment].
GraphQLObjectType<NestedAttachment> get nestedAttachmentGraphQLType =>
    _nestedAttachmentGraphQLType.value;

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

enum KeyedAttachmentField {
  createdAt,
}

class KeyedAttachmentValidationFields {
  const KeyedAttachmentValidationFields(this.errorsMap);
  final Map<KeyedAttachmentField, List<ValidaError>> errorsMap;

  List<ValidaError> get createdAt =>
      errorsMap[KeyedAttachmentField.createdAt] ?? const [];
}

class KeyedAttachmentValidation
    extends Validation<KeyedAttachment, KeyedAttachmentField> {
  KeyedAttachmentValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);
  @override
  final Map<KeyedAttachmentField, List<ValidaError>> errorsMap;
  @override
  final KeyedAttachment value;
  @override
  final KeyedAttachmentValidationFields fields;

  /// Validates [value] and returns a [KeyedAttachmentValidation] with the errors found as a result
  static KeyedAttachmentValidation fromValue(KeyedAttachment value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <KeyedAttachmentField, List<ValidaError>>{
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return KeyedAttachmentValidation(
        errors, value, KeyedAttachmentValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      KeyedAttachmentField.createdAt: ValidaDate(max: 'now'),
    },
    getField: _getField,
  );

  static List<ValidaError> _globalValidate(KeyedAttachment value) => [];

  static Object? _getField(KeyedAttachment value, String field) {
    switch (field) {
      case 'id':
        return value.id;
      case 'name':
        return value.name;
      case 'createdAt':
        return value.createdAt;
      case 'nested':
        return value.nested;
      case 'hashCode':
        return value.hashCode;
      case 'runtimeType':
        return value.runtimeType;
      default:
        throw Exception('Could not find field "$field" for value $value.');
    }
  }
}
