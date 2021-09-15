part of graphql_schema.src.schema;

class GlobalRef {
  final String name;

  GlobalRef(this.name);
}

final _responseHeadersCtxKey = GlobalRef('response.headers');

class ReqCtx<P> {
  final Map<Object, Object?> globals;
  final Map<String, Object?> args;
  final P object;
  final ReqCtx<Object?>? parentCtx;

  const ReqCtx({
    required this.globals,
    required this.args,
    required this.object,
    required this.parentCtx,
  });

  ReqCtx<T> cast<T>() {
    if (this is ReqCtx<T>) {
      return this as ReqCtx<T>;
    }
    return ReqCtx(
      globals: globals,
      args: args,
      object: object as T,
      parentCtx: parentCtx,
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
