import 'dart:convert' show utf8;

import 'package:crypto/crypto.dart' show sha256;
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_schema/leto_schema.dart';

final tasksSchema = GraphQLSchema(
  queryType: objectType(
    'Query',
    fields: [
      getTasksGraphQLField,
    ],
  ),
);

const query = '''
{ getTasks {
  id
  name
  description
  image
  weight
  extra
  createdTimestamp
  assignedTo {
    id
    name
  }
} }
''';
const query2 = '''
{ getTasks {
  id
  assignedTo {
    id
    name
  }
} }
''';

final queryHash = sha256.convert(utf8.encode(query)).toString();
final query2Hash = sha256.convert(utf8.encode(query2)).toString();
