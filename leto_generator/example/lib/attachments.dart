import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:valida/valida.dart';

part 'attachments.g.dart';

const keyedAttachmentGraphQLStrings = [
  '''
type KeyedAttachment @key(fields: "id") @key(fields: "name nested {id}") {
  id: ID!
  name: String!
  createdAt: Date! @valida(jsonSpec: """
{"variantType":"date","max":"now"}
""")
  nested: NestedAttachment!
}''',
  '''
type NestedAttachment @key(fields: "id") {
  id: Int!
}'''
];

@Valida()
@AttachFn(KeyedAttachment.attachments)
@GraphQLObject()
class KeyedAttachment {
  final String id;
  final String name;
  @ValidaDate(max: 'now')
  final DateTime createdAt;
  final NestedAttachment nested;

  KeyedAttachment({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.nested,
  });

  static List<AttachmentWithValidation> attachments() {
    return const [
      KeyAttachment('id'),
      KeyAttachment('name nested {id}'),
    ];
  }
}

@AttachFn(NestedAttachment.attachments)
@GraphQLObject()
class NestedAttachment {
  final int id;

  NestedAttachment({
    required this.id,
  });

  static List<AttachmentWithValidation> attachments() {
    return const [
      KeyAttachment('id'),
    ];
  }
}

@Query()
KeyedAttachment getKeyedAttachment() {
  return KeyedAttachment(
    id: '22',
    name: 'keyedName',
    nested: NestedAttachment(id: 98),
    createdAt: DateTime.now().subtract(
      const Duration(hours: 2),
    ),
  );
}
