# Leto Shelf <!-- omit in toc -->

Leto GraphQL web server bindings and utilities for shelf.

## Table of Contents <!-- omit in toc -->
- [Quickstart](#quickstart)
- [Install](#install)
- [Server example](#server-example)
- [Handlers](#handlers)
  - [graphQLHttp](#graphqlhttp)
  - [graphQLWebSocket](#graphqlwebsocket)
  - [Web UI Explorers](#web-ui-explorers)
    - [GraphiQL](#graphiql)
    - [Playground](#playground)
    - [Altair](#altair)
- [Features and Utilities](#features-and-utilities)
  - [File Upload](#file-upload)
  - [Requests and Responses](#requests-and-responses)
    - [Request](#request)
    - [Headers](#headers)
    - [Custom Response](#custom-response)
- [Middlewares](#middlewares)
  - [etag](#etag)
  - [cors](#cors)
  - [jsonParse](#jsonparse)

# Quickstart

For more general information and examples for building GraphQL schemas and servers using Leto, please see the main repository's https://github.com/juancastillo0/leto README. This README only contains information associated with bindings and utilities for building Leto powered web servers with shelf.

Most sections in this README have a "Tests" link. You can read the tests source code for usage examples.

# Install

Add dependencies to your pubspec.yaml

```yaml
dependencies:
  leto_schema: ^0.0.1
  leto: ^0.0.1
  leto_shelf: ^0.0.1

  shelf: ^1.0.0
  shelf_router: ^1.0.0
  # Not nessary for the server, just for testing it
  http: ^1.0.0

dev_dependencies:
  # Only if you use code generation
  leto_generator: ^0.0.1
```


# Server example

A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto/tree/main/chat_example

# Handlers

This package provides `shelf` handlers for answering HTTP requests.

## graphQLHttp

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/shelf_graphql_test.dart)

Handles POST and GET requests for "application/graphql", "application/json", "application/graphql+json" and "multipart/form-data" mime types. The implementations follows the https://github.com/graphql/graphql-over-http/blob/main/spec/GraphQLOverHTTP.md and https://github.com/jaydenseric/graphql-multipart-request-spec specifications.

- POST requests support GraphQL Query and Mutation operations
- We restrict GET requests to allow only GraphQL Query operations
- Support for file Upload with "multipart/form-data" bodies

A 200 status code with a JSON body will be sent by default, with a structure following the [spec](http://spec.graphql.org/draft/#sec-Response).

A 400 status code will be sent for requests that do not follow the specifications.

// TODO: A 400 status code will be sent for requests with validation errors.

A 405, method not allowed, status code will be sent for Mutation operations in GET requests

## graphQLWebSocket

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/mutation_and_subscription_test.dart)

Handles Query, Mutation and Subscription requests using the "graphql-ws" or "graphql-transport-ws" Web Socket subprotocols. When using this handler, the [headers](#headers) and [response](#custom-response) utilities will have no effect.

The `validateIncomingConnection` parameter allows you to support authentication for your Web Socket connection, it also passes a `GraphQLWebSocketServer` as an argument which could be used for closing the connection. Some ping and keep alive `Duration` configuration parameters are provided to remove stale connection or identify problems when reaching the client.


// TODO: throwing in the `subscribe` field function

## Web UI Explorers

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/graphql_ui_test.dart)

These web pages will allow you to explore your GraphQL Schema, view all the types and fields, read each element's documentation, and execute requests against a GraphQL server. 

Usually exposed as static HTML in your deployed server. Each has multiple configurations for determining the default tabs, queries and variables, the GraphQL HTTP and WebSocket (subscription) endpoints, the UI's theme and more.

All of the static HTML files and configurations can be found in the [graphql_ui folder](https://github.com/juancastillo0/leto/tree/main/leto_shelf/lib/src/graphql_ui).

### GraphiQL

[Documentation](https://github.com/graphql/graphiql/tree/main/packages/graphiql#readme). Use `graphiqlHandler`. The classic GraphQL explorer
### Playground

[Documentation](https://github.com/graphql/graphql-playground). Use `playgroundHandler`. Support for multiple tabs, subscriptions.
### Altair

[Documentation](https://github.com/altair-graphql/altair). Use `altairHandler`. Support for file Upload, multiple tabs, subscriptions, plugins.


# Features and Utilities

Some useful utilities and bindings for working with shelf HTTP requests and responses in Leto.

## File Upload

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/file_upload_test.dart)

Only available using "multipart/form-data" bodies, your HTTP client will need to follow the https://github.com/jaydenseric/graphql-multipart-request-spec specification. Can't we used with Web Sockets.

Use the `Upload` class and the `Upload.graphQLType` for building schemas. When using code generation `Upload.graphQLType` will be used with no additional configuration, you just need to put the `Upload` type as input to a resolver or as a field in an Input Object.

## Requests and Responses

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/req_ctx_utils_test.dart)

### Request

You can access the shelf HTTP request using the `extractRequest` function or the Dart extension (provided in the same file) for Leto's field resolver `Ctx` argument.

```dart
import 'package:leto_schema/leto_schema.dart'; // Query and Ctx
import 'package:leto_shelf/leto_shelf.dart'; // extractRequest and ctx.request extension

@Query()
String getName(Ctx ctx) {
  final Request request = ctx.request;
  assert(request == extractRequest(ctx));
  assert(request.headersAll is Map<String, List<String>>);
  return '';
}
```
### Headers

- appendHeader

Adds a new value to a given header, does not override the previously set values for the header.

- changeHeader

Sets a new value to a given header, will override the previously set values for the header.
### Custom Response

- updateResponse

If the new response contains a body or the status code is different from 200, the new response will be returned without modification. However, if the new response does not contain a body and it's status code is 200 (maybe you only changed the headers), the default GraphQL json body will be appended along side the "application/json" content type response header.

```dart
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';

@Query()
String getName(Ctx ctx) {
  ctx.appendHeader('custom-header', 'headers-value');
  assert(extractResponse(ctx).headersAll['custom-header']![0] == 'headers-value');
  ctx.changeHeader('custom-header', 'headers-value-2'); // override

  updateResponse(ctx, (response) => response.change(
    // Could also call `ctx.appendHeader` twice for each value
    headers: {'custom-header2': ['h1', 'h2']}
  ));

  final Response response = extractResponse(ctx);
  assert(response.headersAll['custom-header']![0] == 'headers-value-2'); // overridden
  assert(response.headersAll['custom-header2']![0] == 'h1');
  assert(response.headersAll['custom-header2']![1] == 'h2');

  return '';
}
```

# Middlewares

Other shelf middlewares not really specific to GraphQL servers.

## etag

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/etag_test.dart)

[ETag](https://developer.mozilla.org/docs/Web/HTTP/Headers/ETag) and [If-None-Match](https://developer.mozilla.org/docs/Web/HTTP/Headers/If-None-Match) headers computation and verification.

## cors

[Tests](https://github.com/juancastillo0/leto/blob/main/leto_shelf/test/cors_test.dart)

[CORS](https://developer.mozilla.org/docs/Glossary/CORS) requests configuration.

## jsonParse

Parse JSON bodies
