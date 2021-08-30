import 'package:graphql_schema/graphql_schema.dart';
import 'package:test/test.dart';

final Matcher throwsAGraphQLException =
    throwsA(predicate((Object? x) => x is GraphQLException, 'is a GraphQL exception'));
