import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:oxidized/oxidized.dart';
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';
import 'package:shelf_graphql/src/server_utils/uploaded_file.dart';

class MultiPartData {
  final Map<String, String> body;
  final List<UploadedFile> files;

  const MultiPartData(this.body, this.files);
}

Result<GraphQLRequest, String> graphqlRequestFromMultiPartFormData(
  MultiPartData data,
) {
  final operationsStr = data.body['operations'];
  if (operationsStr == null) {
    return Err('Missing "operations" field.');
  }
  final Object? _operations = json.decode(operationsStr);
  final List<Object?> operationsList =
      _operations is List ? _operations : [_operations];
  if (operationsList.isEmpty) {
    return Err('"operations" field should have at least one operation.');
  }

  GraphQLRequest? current;
  for (final operation in operationsList.reversed) {
    if (operation is! Map<String, Object?>) {
      return Err('"operations" field must decode to a JSON object.');
    } else if (operation['query'] is! String) {
      return Err('"operations.query" field must be a String.');
    } else if (operation['operationName'] is! String?) {
      return Err('"operations.operationName" field must be a String?.');
    } else if (operation['variables'] is! Map<String, Object?>) {
      return Err('"operations.variables" field must be a Map.');
    } else if (operation['extensions'] is! Map<String, Object?>?) {
      return Err('"operations.extensions" field must be a Map.');
    }

    final Object? map =
        data.body.containsKey('map') ? json.decode(data.body['map']!) : null;
    if (map is! Map<String, Object?>) {
      return Err('"map" field must decode to a JSON object.');
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
  required List<UploadedFile> files,
}) {
  for (final entry in map.entries) {
    final file = files.firstWhereOrNull(
      (f) => f.name == entry.key,
    );
    if (file == null) {
      return Err(
        '"map" contained key "${entry.key}", but no uploaded file '
        'has that name.',
      );
    }
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
