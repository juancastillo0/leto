import 'package:gql/language.dart' as gql;
import 'package:gql_exec/gql_exec.dart' as gql_exec;
import 'package:gql_link/gql_link.dart' as gql_link;

export 'package:gql_websocket_link/gql_websocket_link.dart';

extension RequestRaw on gql_link.Link {
  Stream<gql_exec.Response> requestRaw(
    String document, {
    String? operationName,
    Map<String, Object?> variables = const {},
    Map<String, Object?>? extensions,
  }) {
    gql_exec.Context? context;
    if (extensions != null) {
      context = gql_exec.Context.fromList(
        [gql_exec.RequestExtensionsThunk((_) => extensions)],
      );
    }
    return request(
      gql_exec.Request(
        operation: gql_exec.Operation(
          document: gql.parseString(document),
          operationName: operationName,
        ),
        variables: variables,
        context: context ?? const gql_exec.Context(),
      ),
    );
  }
}
