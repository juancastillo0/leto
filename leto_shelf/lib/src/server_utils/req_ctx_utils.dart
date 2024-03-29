import 'dart:developer';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';

final _requestCtxRef = ScopedRef<_LetoShelfRequest?>.local(
  (_) => null,
  name: '__request',
);

/// Overrides for setting [_requestCtxRef]
/// in a GraphQL request
class RequestOverrides {
  RequestOverrides._(this._request);
  final _LetoShelfRequest _request;

  /// Scoped overrides to be used in [GraphQL.parseAndExecute].
  List<ScopedOverride> get overrides => [
        _requestCtxRef.override((_) => _request),
      ];
}

/// Creates a scope with leto_shelf request state
RequestOverrides makeRequestScopedMap(
  Request request, {
  required bool isFromWebSocket,
}) {
  return RequestOverrides._(
    _LetoShelfRequest(
      isFromWebSocket: isFromWebSocket,
      request: request,
    ),
  );
}

class _LetoShelfRequest {
  final Request request;
  final bool isFromWebSocket;

  /// Mutable response
  Response? response;

  _LetoShelfRequest({
    required this.request,
    required this.isFromWebSocket,
  });
}

/// Utilities for working with shelf requests and responses
/// from GraphQL field resolvers
extension ReqCtxShelf on Ctx {
  /// The request associated with this resolver context
  Request get request => extractRequest(this);

  /// The response associated with this resolver context
  ///
  /// An empty response with 200 status code if it wasn't overridden
  Response get response => extractResponse(this);

  /// Whether this request is from a Web Socket
  ///
  /// If true, all the functions that modify the
  /// response headers will not have any effect
  bool get isFromWebSocket => extractIsFromWebSocket(this);

  /// Updates the response associated with this resolver context
  ///
  /// This will override the default response sent by the [graphQLHttp] handler.
  /// If the new response has a status code different from 200
  /// or a non-empty body, the response will be returned as is. Otherwise
  /// the default GraphQL json body will be appended to the response, leaving
  /// the [Response.headers] and [Response.context] untouched.
  Response updateResponse(Response Function(Response) update) =>
      _updateResponse(this, update);

  /// Adds a [value] to the header [key] in the response
  Response appendHeader(String key, String value) {
    return updateResponse((resp) {
      final list = List<String>.of(resp.headersAll[key] ?? []);
      list.add(value);
      return resp.change(headers: {key: list});
    });
  }

  /// Sets a [value] to the header [key] in the response
  Response changeHeader(String key, String value) {
    return updateResponse((resp) {
      return resp.change(headers: {
        key: [value]
      });
    });
  }
}

_LetoShelfRequest _state(ScopedHolder ctx) {
  final state = _requestCtxRef.get(ctx);
  if (state == null) {
    throw StateError(
      'Request and Response leto_shelf utilities can only be called from'
      ' a context that used the `graphQLHttp` or `graphQLWebSocket` handlers'
      ' or manually using the `makeRequestScopedMap` function.',
    );
  }
  return state;
}

/// Returns the request associated with this [ctx]
Request extractRequest(ScopedHolder ctx) {
  return _state(ctx).request;
}

/// Returns the request associated with this [ctx]
bool extractIsFromWebSocket(ScopedHolder ctx) {
  return _state(ctx).isFromWebSocket;
}

/// Returns the response associated with this [ctx]
///
/// An empty response with 200 status code if it wasn't overridden
Response extractResponse(ScopedHolder ctx) {
  return _state(ctx).response ?? Response.ok(null);
}

/// Returns the response associated with this [ctx]
///
/// An empty response with 200 status code if it wasn't overridden
Response extractResponseFromMap(RequestOverrides overrides) {
  final value = overrides._request;
  return value.response ?? Response.ok(null);
}

const _updateResponse = updateResponse;

/// Updates the response associated with this resolver context
///
/// This will override the default response sent by the [graphQLHttp] handler.
/// If the new response has a status code different from 200
/// or a non-empty body, the response will be returned as is. Otherwise
/// the default GraphQL json body will be appended to the response, leaving
/// the [Response.headers] and [Response.context] untouched.
Response updateResponse(Ctx ctx, Response Function(Response) update) {
  final state = _state(ctx);
  if (state.isFromWebSocket) {
    // warning
    log(
      'Modifying a response in a Web Socket request has no effect',
      level: 900,
    );
  }
  final prev = extractResponse(ctx);
  final response = update(prev);
  state.response = response;
  return response;
}
