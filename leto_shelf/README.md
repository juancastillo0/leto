# Leto Shelf <!-- omit in toc -->

Leto GraphQL web server bindings and utilities for shelf.

## Table of Contents <!-- omit in toc -->
- [Quickstart](#quickstart)
- [Install](#install)
- [Server example](#server-example)
- [Handlers](#handlers)
  - [graphqlHttp](#graphqlhttp)
  - [graphqlWebSocket](#graphqlwebsocket)
  - [Web UI Explorers](#web-ui-explorers)
    - [Graphiql](#graphiql)
    - [Playground](#playground)
    - [Altait](#altait)
- [Features and Utilities](#features-and-utilities)
  - [File Upload](#file-upload)
  - [Headers](#headers)
- [Middlewares](#middlewares)
  - [etag](#etag)
  - [cors](#cors)
  - [jsonParse](#jsonparse)

# Quickstart

For more general information about building GraphQL schemas using Leto please see the main repository https://github.com/juancastillo0/leto.

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

## graphqlHttp

Handles POST and GET requests for "application/graphql", "application/json" and "application/graphql+json" and "application/multipart" mime types.

- POST requests support GraphQL Query and Mutation operations
- GET requests only support GraphQL Query operations
- Support for file Upload following 

## graphqlWebSocket

Handles Query, Mutation and Subscription requests using the "graphql-ws" or "graphql-transport-ws" Web Socket subprotocols.

## Web UI Explorers


### Graphiql
### Playground
### Altait


# Features and Utilities

Some useful utilities and bindings for working with HTTP requests in Leto GraphQL.

## File Upload

## Headers

- updateResponse
- appendHeader
- changeHeader

# Middlewares

## etag

ETag and If-None-Match headers computation and verification.

## cors

CORS requests configuration

## jsonParse

Parse JSON bodies


