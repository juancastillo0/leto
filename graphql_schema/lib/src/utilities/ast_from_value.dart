import 'package:collection/collection.dart';
import 'package:gql/ast.dart' as ast;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_schema/src/utilities/print_schema.dart';
import 'package:source_span/source_span.dart' show FileSpan;

ast.ValueNode? astFromValue(Object? value, GraphQLType type) {
  if (type is GraphQLNonNullType) {
    final astNode = astFromValue(value, type.ofType);
    if (astNode == const ast.NullValueNode()) {
      return null;
    }
    return astNode;
  }
  if (value == null) {
    return const ast.NullValueNode();
  }

  ast.ObjectValueNode astFromObject(
    Map<String, Object?> value,
    Iterable<ObjectField> fields,
  ) {
    return ast.ObjectValueNode(fields: [
      ...value.entries.map(
        (e) {
          final astNode = astFromValue(
            e.value,
            fields.firstWhere((f) => f.name == e.key).type,
          );
          if (astNode == null) {
            return null;
          }
          return ast.ObjectFieldNode(
            name: ast.NameNode(
              value: e.key,
            ),
            value: astNode,
          );
        },
      ).whereType(),
    ]);
  }

  return type.when(
    enum_: (enum_) => ast.EnumValueNode(
      name: ast.NameNode(
        value: enum_.serialize(value),
      ),
    ),
    scalar: (scalar) {
      final serialized = type.serialize(value);
      return astFromUntypedValue(serialized);
    },
    input: (input) {
      return astFromObject(input.serializeSafe(value), input.fields);
    },
    object: (object) {
      throw ArgumentError('astFromValue can only be called with input types.');
      // TODO: should we support this?
      // return astFromObject(object.serializeSafe(value), object.fields);
    },
    union: (union) {
      throw ArgumentError('astFromValue can only be called with input types.');
    },
    list: (list) {
      if (value is List) {
        return ast.ListValueNode(values: [
          ...value.map((e) => astFromValue(e, list.ofType)).whereType(),
        ]);
      }
      return astFromValue(value, list.ofType);
    },
    nonNullable: (nonNullable) => astFromValue(value, nonNullable.ofType),
  );
}

Object? valueFromAst(
  GraphQLType? type,
  ast.ValueNode node,
  Map<String, Object?>? variables, {
  FileSpan? span,
  String key = 'value',
}) {
  final _span = node.span ?? span;
  final value = node.when(
    string: (string) => string.value,
    int_: (int_) => int.parse(int_.value),
    float: (float) => double.parse(float.value),
    boolean: (boolean) => boolean.value,
    object: (object) {
      GraphQLType<Object, Object>? _type = type;
      if (_type is GraphQLNonNullType) _type = _type.ofType;
      if (_type is GraphQLScalarType) _type = null;
      if (_type != null && _type is! GraphQLInputObjectType) {
        throw GraphQLError(
          'Expected value to be a $_type. Got: ${printAST(object)}.',
          locations: GraphQLErrorLocation.listFromSource(_span?.start),
        );
      }
      final _objType = _type as GraphQLInputObjectType?;
      return Map.fromEntries(
        object.fields.map(
          (e) {
            final fieldName = e.name.value;
            final _fieldSpan = e.span ?? e.value.span ?? e.name.span ?? _span;
            final _type =
                _objType?.fields.firstWhereOrNull((f) => f.name == fieldName);

            return MapEntry(
              fieldName,
              valueFromAst(
                _type?.type,
                e.value,
                variables,
                span: _fieldSpan,
                key: '$key["$fieldName"]',
              ),
            );
          },
        ),
      );
    },
    list: (list) {
      GraphQLType<Object, Object>? _type = type;
      if (_type is GraphQLNonNullType) _type = _type.ofType;
      if (_type is GraphQLScalarType) _type = null;
      if (_type != null && _type is! GraphQLListType) {
        throw GraphQLError(
          'Expected value to be a $_type. Got: ${printAST(list)}.',
          locations: GraphQLErrorLocation.listFromSource(_span?.start),
        );
      }
      return List.from(
        list.values.mapIndexed(
          (index, v) => valueFromAst(
            (_type as GraphQLListType?)?.ofType,
            v,
            variables,
            span: _span,
            key: '$key[$index]',
          ),
        ),
      );
    },
    enum_: (enum_) => EnumValue(enum_.name.value),
    null_: (null_) => null,
    variable: (variable) => variables?[variable.name],
  );

  if (type != null) {
    if (value == null) {
      if (type.isNonNullable) {
        throw GraphQLError(
          'Expected a non-null value of type $type int $key.',
          locations: GraphQLErrorLocation.listFromSource(_span?.start),
        );
      }
      return null;
    }
    // TODO: validate shallow (not nested properties, since they where already validated)
    final result = type.validate(key, value);
    if (result.successful) {
      return result.value;
    } else {
      throw GraphQLError(
        result.errors.first,
        locations: GraphQLErrorLocation.listFromSource(_span?.start),
      );
    }
  }
  return value;
}

ast.ValueNode astFromUntypedValue(Object value) {
  if (value is String) {
    return ast.StringValueNode(
      value: value,
      isBlock: value.length > 100,
    );
  } else if (value is int) {
    return ast.IntValueNode(value: value.toString());
  } else if (value is double) {
    return ast.FloatValueNode(value: value.toString());
  } else if (value is bool) {
    return ast.BooleanValueNode(value: value);
  } else if (value is Map<String, Object?>) {
    return ast.ObjectValueNode(fields: [
      ...value.entries.map(
        (e) {
          return ast.ObjectFieldNode(
            name: ast.NameNode(
              value: e.key,
            ),
            value: e.value == null
                ? const ast.NullValueNode()
                : astFromUntypedValue(e.value!),
          );
        },
      ),
    ]);
  } else if (value is List<Object?>) {
    return ast.ListValueNode(values: [
      ...value.map(
        (e) => e == null ? const ast.NullValueNode() : astFromUntypedValue(e),
      ),
    ]);
  }
  // TODO:
  throw Error();
}

extension ValueNodeWhen on ast.ValueNode {
  T when<T>({
    required T Function(ast.StringValueNode) string,
    required T Function(ast.IntValueNode) int_,
    required T Function(ast.FloatValueNode) float,
    required T Function(ast.BooleanValueNode) boolean,
    required T Function(ast.ObjectValueNode) object,
    required T Function(ast.ListValueNode) list,
    required T Function(ast.EnumValueNode) enum_,
    required T Function(ast.NullValueNode) null_,
    required T Function(ast.VariableNode) variable,
  }) {
    final v = this;
    if (v is ast.StringValueNode) return string(v);
    if (v is ast.IntValueNode) return int_(v);
    if (v is ast.FloatValueNode) return float(v);
    if (v is ast.BooleanValueNode) return boolean(v);
    if (v is ast.ObjectValueNode) return object(v);
    if (v is ast.ListValueNode) return list(v);
    if (v is ast.EnumValueNode) return enum_(v);
    if (v is ast.NullValueNode) return null_(v);
    if (v is ast.VariableNode) return variable(v);
    throw Error();
  }
}
