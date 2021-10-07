part of graphql_schema.src.schema;

class GlobalRef {
  final String name;

  GlobalRef(this.name);
}

final _responseHeadersCtxKey = GlobalRef('response.headers');

class ReqCtx<P extends Object> {
  final Map<Object, Object?> globals;
  final Map<String, Object?> args;
  final P object;
  final ResolveObjectCtx<Object> parentCtx;
  final GraphQLObjectField<Object, Object, Object> field;
  final String pathItem;

  List<Object> get path => parentCtx.path.followedBy([pathItem]).toList();

  final Map<String, List<FieldNode>>? Function() groupedFieldSet;

  const ReqCtx({
    required this.globals,
    required this.args,
    required this.object,
    required this.parentCtx,
    required this.field,
    required this.pathItem,
    required this.groupedFieldSet,
  });

  ReqCtx<T> cast<T extends Object>() {
    if (this is ReqCtx<T>) {
      return this as ReqCtx<T>;
    }
    return ReqCtx(
      globals: globals,
      args: args,
      object: object as T,
      parentCtx: parentCtx,
      pathItem: pathItem,
      field: field,
      groupedFieldSet: groupedFieldSet,
    );
  }

  // TODO: headersAll Map<String, List<String>>
  // TODO: should we leave it to the implementors?
  Map<String, String> get responseHeaders {
    return globals.putIfAbsent(
      _responseHeadersCtxKey,
      () => <String, String>{},
    )! as Map<String, String>;
  }

  static Map<String, String>? headersFromGlobals(
    Map<Object, Object?> globals,
  ) =>
      globals[_responseHeadersCtxKey] as Map<String, String>?;
}

class ResolveCtx {
  final errors = <GraphQLExceptionError>[];
  final GraphQLSchema schema;
  SerdeCtx get serdeCtx => schema.serdeCtx;
  final DocumentNode document;
  final Object rootValue;
  final Map<String, dynamic> variableValues;
  final Map<Object, dynamic> globalVariables;
  final Map<String, dynamic>? extensions;

  ResolveCtx({
    required this.schema,
    required this.document,
    required this.rootValue,
    required this.variableValues,
    required this.globalVariables,
    required this.extensions,
  });
}

class ResolveObjectCtx<P extends Object> {
  final ResolveCtx base;

  SerdeCtx get serdeCtx => base.serdeCtx;
  Map<String, dynamic> get variableValues => base.variableValues;
  Map<Object, dynamic> get globalVariables => base.globalVariables;
  DocumentNode get document => base.document;

  final GraphQLObjectType<P> objectType;
  final P objectValue;
  final ResolveObjectCtx<Object>? parent;
  final Object? pathItem;
  final Map<String, List<FieldNode>> groupedFieldSet;

  Iterable<Object> get path => parent == null
      ? [if (pathItem != null) pathItem!]
      : parent!.path.followedBy([if (pathItem != null) pathItem!]);

  ResolveObjectCtx({
    required this.pathItem,
    required this.base,
    required this.objectType,
    required this.objectValue,
    required this.parent,
    required this.groupedFieldSet,
  });

  bool _didSerialized = false;
  Map<String, dynamic>? _serializedObject;
  Map<String, Object?>? serializedObject() {
    if (!_didSerialized) {
      try {
        try {
          final serializer = serdeCtx.ofValue(objectType.generic.type);
          if (serializer != null) {
            _serializedObject =
                serializer.toJson(objectValue)! as Map<String, dynamic>;
          } else {
            _serializedObject =
                serdeCtx.toJson(objectValue)! as Map<String, dynamic>;
          }
        } catch (e) {
          _serializedObject = objectType.serializeSafe(
            objectValue,
            nested: false,
          );
        }
      } catch (_) {}
      _didSerialized = true;
    }
    return _serializedObject;
  }
}

// class ResolveFieldCtx<T, P> {
//   final ResolveObjectCtx<P> objectCtx;
//   final String fieldName;
//   final FieldNode field;
//   final GraphQLObjectField<T, Object?, P> objectField;

//   const ResolveFieldCtx({
//     required this.objectCtx,
//     required this.fieldName,
//     required this.field,
//     required this.objectField,
//   });
// }