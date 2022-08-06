// ignore_for_file: constant_identifier_names

part of leto_schema.src.schema;

/// Base object decorator.
///
/// Use [GraphQLInput] or [GraphQLObject]
class GraphQLObjectDec {}

/// Signifies that a class should statically generate a [GraphQLInputObjectType]
@Target({TargetKind.classType})
class GraphQLInput implements GraphQLObjectDec {
  /// Signifies that a class should statically
  /// generate a [GraphQLInputObjectType]
  ///
  /// The class should have a `fromJson` constructor or static method.
  /// For generic type parameters, `fromJson` should have other positional
  /// parameters with functions that receive an Object? and
  /// return an instance of the generic type
  const GraphQLInput({
    this.name,
    this.oneOf,
    this.constructor,
  });

  /// The name of the generated [GraphQLInputObjectType]
  final String? name;

  /// Whether the input object should contain only one of the class' fields
  /// For more information: [GraphQLInputObjectType.isOneOf]
  final bool? oneOf;

  /// The name of the constructor used to extract the input object's fields
  final String? constructor;
}

/// Signifies that a class should statically generate a [GraphQLEnumType].
@Target({TargetKind.classType, TargetKind.enumType})
class GraphQLEnum implements GraphQLObjectDec {
  /// Signifies that a class should statically generate a [GraphQLEnumType].
  ///
  /// ```dart
  /// @GraphQLEnum(valuesCase: EnumNameCase.CONSTANT_CASE)
  /// enum SimpleEnum {
  ///   @Deprecated('use VARIANT_ONE_NEW')
  ///   variantOne,
  ///   variantOneNew,
  ///
  ///   /// documentation for variant two
  ///   variantTwo,
  /// }
  /// ```
  ///
  /// Will generated the following GraphQL enum definition:
  ///
  /// ```graphql
  /// enum SimpleEnum {
  ///   VARIANT_ONE @deprecated(reason: "use VARIANT_ONE_NEW")
  ///   VARIANT_ONE_NEW
  ///
  ///   """documentation for variant two"""
  ///    VARIANT_TWO
  /// }
  /// ```
  ///
  /// If used as an annotation for a class you should annotate the
  /// different values with [GraphQLEnumVariant], they should all be static
  /// fields with the same type as the annotated class.
  ///
  /// ```dart
  /// @GraphQLEnum()
  /// class ClassEnum {
  ///   final int code;
  ///   final String value;
  ///
  ///   const ClassEnum(this.code, this.value);
  ///
  ///   @GraphQLEnumVariant()
  ///   static const variantOne = ClassEnum(100, 'value100');
  ///   @GraphQLEnumVariant()
  ///   static const variantOne = ClassEnum(200, 'value200');
  ///
  ///   // other stuff, probably a `ClassEnum.values` list,
  ///   // override the `==` operator and `hashCode` getter or
  ///   // a `package:freezed` style `when` method
  /// }
  /// ```
  const GraphQLEnum({
    this.valuesCase,
    this.name,
  });

  /// The String case for each enum variant name
  final EnumNameCase? valuesCase;

  /// The name of the generated [GraphQLEnumType].
  /// By default it will be the class or enum name.
  final String? name;
}

/// The String case associated with an enum variant name
enum EnumNameCase {
  /// CONSTANT_CASE
  CONSTANT_CASE,

  /// snake_case
  snake_case,

  /// PascalCase
  PascalCase,

  /// Pascal_Underscore_Case
  Pascal_Underscore_Case,

  /// camelCase
  camelCase,

  /// overrides the default [EnumNameCase] provided
  /// in the `build.yaml` config. Will use the Dart enum variant names
  /// or static field names
  none,
}

/// Signifies that a static field should statically
/// generate a [GraphQLEnumValue] in a [GraphQLEnumType].
@Target({TargetKind.field})
class GraphQLEnumVariant {
  /// Overrides the name of the variant, by default it will be the
  /// name of the field subject to [EnumNameCase].
  final String? name;

  /// Signifies that a static field should statically
  /// generate a [GraphQLEnumValue] in a [GraphQLEnumType].
  const GraphQLEnumVariant({this.name});
}

/// Signifies that a class should statically generate a [GraphQLUnionType].
@Target({TargetKind.classType})
class GraphQLUnion implements GraphQLObjectDec {
  // TODO: 2G don't generate the union object wrappers if all of them have
  //  only one property of the same name and the property is an object
  final bool? unnestIfEqual;

  /// The name of the generated [GraphQLUnionType]
  final String? name;

  /// Signifies that a class should statically generate a [GraphQLUnionType].
  const GraphQLUnion({
    this.unnestIfEqual,
    this.name,
  });
}

/// A typedef for [GraphQLObject]. You should use [GraphQLObject] instead.
/// It was renamed, however it has the same functionality.
@Deprecated('Use GraphQLObject instead of GraphQLClass.')
typedef GraphQLClass = GraphQLObject;

/// Signifies that a class should statically generate a [GraphQLType].
@Target({TargetKind.classType})
class GraphQLObject implements GraphQLObjectDec {
  /// Signifies that a class should statically generate a [GraphQLType].
  ///
  /// Generates a [GraphQLObjectType] for classes
  /// with [GraphQLObjectType.isInterface] == true for abstract classes,
  /// a [GraphQLEnumType] for enums
  /// and a [GraphQLUnionType] for freezed unions.
  ///
  /// if [omitFields] is true, omits all fields by default, you would need to
  /// decorate explicitly with [GraphQLField]. No need to pass
  /// `omit: false` in [GraphQLField]'s constructor.
  /// [interfaces] are the getters of [GraphQLObjectType]
  /// implemented by this object.
  const GraphQLObject({
    this.interfaces = const [],
    this.omitFields,
    this.nullableFields,
    this.name,
  });

  /// The interfaces implemented by this [GraphQLObjectType]
  final List<String> interfaces;

  /// Whether all fields should be omitted by default.
  /// Can be overridden with [GraphQLField.omit] or globally configured
  /// in your `build.yaml` file.
  final bool? omitFields;

  /// Whether all fields should be nullable by default.
  /// Can be overridden with [GraphQLField.nullable] or globally configured
  /// in your `build.yaml` file.
  final bool? nullableFields;

  /// The name of the generated [GraphQLType]
  final String? name;

  // TODO: 2G final bool generateInterface
}

/// An annotation for configuring a [GraphQLFieldInput] within a resolver
///
/// if [inline] is true, the properties of a [GraphQLInputObjectType] will be
/// inlined into the resolver inputs.
///
/// Example:
///
/// ```dart
/// @GraphQLInput()
/// class InputModel {
///   final String name;
///   final DateTime? birthDate;
///
///   const InputModel(this.name, this.birthDate);
///
///   factory InputModel.fromJson(Map<String, Object?> json)
///      => InputModel(
///           json['name']! as String,
///           json['birthDate'] == null
///               ? null : DateTime.parse(json['birthDate']! as String)
///         );
/// }
///
/// @Mutation()
/// bool createModel(
///   ReqCtx ctx,
///   @GraphQLArg(inline: true) InputModel model,
///   // The amount!
///   int amount = 24,
/// ) {
///    final String name = model.name;
///    final DateTime? birthDate = model.birthDate;
///
///    return birthDate == null || DateTime.now().isAfter(birthDate);
/// }
/// ```
///
/// Results in the following schema:
///
/// ```graphql
/// input InputModel {
///   name: String!
///   birthDate: Date
/// }
///
/// type Mutation {
///   createModel(
///     name: String!,
///     birthDate: Date,
///     """The amount!"""
///     amount: Int! = 24
///   ) : Boolean!
/// }
/// ```
class GraphQLArg {
  /// An annotation for configuring a [GraphQLFieldInput] within a resolver
  ///
  /// if [inline] is true, the properties of a [GraphQLInputObjectType] will be
  /// inlined into the resolver inputs.
  const GraphQLArg({
    bool? inline,
    this.defaultCode,
    this.defaultFunc,
  }) : inline = inline ?? false;

  /// Whether to inline the fields of a [GraphQLInputObjectType]
  /// inside the parameters.
  final bool inline;

  /// The Dart code used to create the default value for the argument.
  ///
  /// Can't specify both [defaultCode] and [defaultFunc].
  final String? defaultCode;

  /// A function which returns the default value for the argument.
  ///
  /// Can't specify both [defaultCode] and [defaultFunc].
  final Object? Function()? defaultFunc;
}

/// An annotation for configuring the generated code of a GraphQL field
class GraphQLField {
  /// An annotation for configuring the generated code of a GraphQL field
  const GraphQLField({
    this.name,
    bool? omit,
    bool? nullable,
    this.type,
  })  : omit = omit ?? false,
        nullable = nullable ?? false;

  /// The name of the [GraphQLObjectField].
  final String? name;

  /// If true, this field will be omitted in the generated [GraphQLObjectType].
  final bool omit;

  /// If true, this field will be nullable even if the
  /// Dart type is non-nullable.
  final bool nullable;

  /// A String containing a getter for the [GraphQLType].
  final String? type;
}

/// Base annotation for GraphQL resolvers.
/// use [GraphQLResolver] or [ClassResolver]
abstract class BaseGraphQLResolver {}

/// Signifies that a function should statically generate a [GraphQLObjectField].
///
/// Use [Mutation], [Query] and [Subscription]
@Target({TargetKind.function, TargetKind.method})
abstract class GraphQLResolver implements BaseGraphQLResolver {
  /// The name of the field to generate
  String? get name;

  /// If the return type of this resolver is a generic type, then
  /// this will be the name of that [GraphQLType]. This will be passed in the
  /// `name` parameter to the generic function which created the type
  String? get genericTypeName;

  // TODO: 1G nullable maybe use and test @GraphQLDocumentation
}

/// Adds [GraphQLAttachments] to a generated [GraphQLElement]
class AttachFn {
  /// A function that returns the [GraphQLAttachments]
  /// to be included in the element
  final GraphQLAttachments Function() attachments;

  /// Adds [GraphQLAttachments] to a generated [GraphQLElement]
  /// by using a static function [attachments]
  const AttachFn(this.attachments);
}

/// Signifies that a class should be used to generated and resolve
/// a set of [GraphQLObjectField]s.
@Target({TargetKind.classType})
class ClassResolver implements BaseGraphQLResolver {
  final String? fieldName;

  /// A custom Dart code getter for the annotated Class instance
  final String? instantiateCode;

  /// Signifies that a class should be used to generated and resolve
  /// a set of [GraphQLObjectField]s.
  ///
  /// The class' methods and getters that you want to expose
  /// as [GraphQLObjectField] should be annotated with [Query],
  /// [Mutation] or [Subscription] to add them to the right root
  /// [GraphQLObjectType] in the [GraphQLSchema].
  const ClassResolver({
    this.fieldName,
    this.instantiateCode,
  });
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the mutation type of a [GraphQLSchema].
class Mutation implements GraphQLResolver {
  @override
  final String? name;
  @override
  final String? genericTypeName;

  /// Signifies that a function should statically generate
  /// a [GraphQLObjectField] within the mutation type of a [GraphQLSchema].
  ///
  /// ```dart
  /// @Mutation()
  /// String? someAction(ReqCtx ctx, {required DateTime createdAt}) {
  ///    final value = ctx.globals[argSize];
  ///    return value is String ? value : null;
  /// }
  /// ```
  const Mutation({
    this.name,
    this.genericTypeName,
  });
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the query type of a [GraphQLSchema].
class Query implements GraphQLResolver {
  @override
  final String? name;
  @override
  final String? genericTypeName;

  /// Signifies that a function should statically generate
  /// a [GraphQLObjectField] within the query type of a [GraphQLSchema].
  ///
  /// ```dart
  /// @Query()
  /// Future<String> getName(ReqCtx ctx, {List<int>? ids}) {
  ///    final value = ctx.globals[argSize];
  ///    return value is String ? value : null;
  /// }
  /// ```
  const Query({
    this.name,
    this.genericTypeName,
  });
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the subscription type of a [GraphQLSchema].
class Subscription implements GraphQLResolver {
  @override
  final String? name;
  @override
  final String? genericTypeName;

  /// Signifies that a function should statically generate
  /// a [GraphQLObjectField] within the subscription type of a [GraphQLSchema].
  ///
  /// ```dart
  /// /// @Subscription()
  /// Stream<String> onActionsPerformed(ReqCtx ctx, int? argSize) {
  ///    final value = ctx.globals[argSize];
  ///    return value is String ? value : null;
  /// }
  /// ```
  const Subscription({
    this.name,
    this.genericTypeName,
  });
}

/// A metadata annotation used to provide documentation and type information
/// to `package:leto_generator` in code generation
class GraphQLDocumentation {
  /// The description of the annotated class, field, or enum value, to be
  /// displayed in tools like GraphiQL.
  final String? description;

  /// The reason the annotated field or enum value was deprecated, if any.
  final String? deprecationReason;

  /// A constant callback that returns an explicit type for the annotated field,
  /// rather than having it be assumed
  final GraphQLType Function()? type;

  /// The name of an explicit type for the annotated field, rather than
  /// having it be assumed.
  final String? typeName;

  /// A metadata annotation used to provide documentation and type information
  /// to `package:leto_generator` in code generation
  const GraphQLDocumentation({
    this.description,
    this.deprecationReason,
    this.type,
    this.typeName,
  });
}
