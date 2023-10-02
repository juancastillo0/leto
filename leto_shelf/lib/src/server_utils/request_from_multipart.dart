import 'dart:convert';

import 'package:leto_shelf/src/server_utils/graphql_request.dart';
import 'package:leto_shelf/src/server_utils/uploaded_file.dart';
import 'package:oxidized/oxidized.dart';

class MultiPartData {
  final Map<String, String> body;
  final List<Upload> files;

  const MultiPartData(this.body, this.files);
}

/// Extracts the [GraphQLRequest] from [data] following the spec
/// https://github.com/jaydenseric/graphql-multipart-request-spec
Result<GraphQLRequest, String> graphQLRequestFromMultiPartFormData(
  MultiPartData data,
) {
  final operationsStr = data.body['operations'];
  if (operationsStr == null) {
    return const Err('Missing "operations" field.');
  }
  final Object? _operations = json.decode(operationsStr);
  final List<Object?> operationsList =
      _operations is List ? _operations : [_operations];
  if (operationsList.isEmpty) {
    return const Err('"operations" field should have at least one operation.');
  }

  final Object? map =
      data.body.containsKey('map') ? json.decode(data.body['map']!) : null;
  if (map is! Map<String, Object?>) {
    return const Err('"map" field must decode to a JSON object.');
  }

  GraphQLRequest? current;
  for (final operation in operationsList.reversed) {
    if (operation is! Map<String, Object?>) {
      return const Err('"operations" field must decode to a JSON object.');
    } else if (operation['query'] is! String) {
      return const Err('"operations.query" field must be a String.');
    } else if (operation['operationName'] is! String?) {
      return const Err('"operations.operationName" field must be a String?.');
    } else if (operation['variables'] is! Map<String, Object?>) {
      return const Err('"operations.variables" field must be a Map.');
    } else if (operation['extensions'] is! Map<String, Object?>?) {
      return const Err('"operations.extensions" field must be a Map.');
    }

    final variablesResult = _assignFilesToVariables(
      operation: operation,
      map: map,
      files: data.files,
    );
    if (variablesResult.isErr()) {
      return Err(variablesResult.unwrapErr());
    }
    final variables = variablesResult.unwrap();

    current = GraphQLRequest(
      query: operation['query']! as String,
      variables: variables,
      child: current,
      isBatched: _operations is List,
      operationName: operation['operationName'] as String?,
      extensions: operation['extensions'] as Map<String, Object?>?,
    );
  }

  return Ok(current!);
}

Result<Map<String, Object?>, String> _assignFilesToVariables({
  required Map<String, Object?> operation,
  required Map<String, Object?> map,
  required List<Upload> files,
}) {
  for (final entry in map.entries) {
    final fileIndex = files.indexWhere(
      (f) => f.name == entry.key,
    );
    if (fileIndex == -1) {
      return Err(
        '"map" contained key "${entry.key}", but no uploaded file '
        'has that name.',
      );
    }
    final file = files[fileIndex];
    if (entry.value is! List) {
      return Err(
        'The value for "${entry.key}" in the "map"'
        ' field was not a JSON array.',
      );
    }
    final objectPaths = entry.value! as List;
    for (final objectPath in objectPaths) {
      final subPaths = (objectPath as String).split('.');
      Object? current = operation;
      for (int i = 0; i < subPaths.length; i++) {
        final name = subPaths[i];
        final parent = subPaths.take(i).join('.');

        if (current is List) {
          final index = int.tryParse(name);
          if (index == null) {
            return Err(
              'Object "$parent" is not a JSON array, but the '
              '"map" field contained a mapping to $parent.$name.',
            );
          }
          if (i == subPaths.length - 1) {
            current[index] = file;
          } else {
            current = current[index];
          }
        } else {
          if (current is! Map) {
            return Err(
              'Object "$parent" is not a JSON object, but the '
              '"map" field contained a mapping to $parent.$name.',
            );
          }
          if (i == subPaths.length - 1) {
            current[name] = file;
          } else {
            current = current[name];
          }
        }
      }
    }
  }
  return Ok(operation['variables']! as Map<String, Object?>);
}
