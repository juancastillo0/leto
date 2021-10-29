import 'package:shelf_graphql/shelf_graphql.dart';

final requestCtxKey = ScopeRef<Request>('__request');
final responseCtxKey = ScopeRef<Response>('__response');

extension ReqCtxShelf on ReqCtx {
  Request get request => extractRequest(this);
  Response get response => extractResponse(this);

  Response updateResponse(Response Function(Response) update) =>
      _updateResponse(this, update);

  Response appendHeader(String key, String value) {
    return updateResponse((resp) {
      final list = List<String>.of(resp.headersAll[key] ?? []);
      list.add(value);
      return resp.change(headers: {key: list});
    });
  }

  Response changeHeader(String key, String value) {
    return updateResponse((resp) {
      return resp.change(headers: {
        key: [value]
      });
    });
  }
}

Request extractRequest(ReqCtx ctx) {
  return requestCtxKey.get(ctx)!;
}

Response extractResponse(ReqCtx ctx) {
  return responseCtxKey.get(ctx) ?? Response.ok(null);
}

const _updateResponse = updateResponse;

Response updateResponse(ReqCtx ctx, Response Function(Response) update) {
  final prev = extractResponse(ctx);
  final response = update(prev);
  responseCtxKey.setScoped(ctx, response);
  return response;
}
