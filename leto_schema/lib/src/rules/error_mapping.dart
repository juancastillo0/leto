import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';

GraphQLError knownArgumentNamesOnDirectivesError({
  required ArgumentNode argNode,
  required String directiveName,
}) {
  return GraphQLError(
    'Unknown argument "${argNode.name.value}" on directive "@${directiveName}".'
    //  + didYouMean(suggestions)
    ,
    locations: GraphQLErrorLocation.firstFromNodes(
      [argNode, argNode.name],
    ),
  );
}

Map<String, Object?> errorExtensions({
  required String specUrl,
  required String errorCode,
}) {
  return {
    'validationError': {
      'spec': specUrl,
      'code': errorCode,
    }
  };
}

class ErrorSpec {
  final String spec;
  final String code;

  /// A specification of a GraphQL error
  const ErrorSpec({
    required this.spec,
    required this.code,
  });

  Map<String, Object?> extensions() {
    return errorExtensions(errorCode: code, specUrl: spec);
  }
}
