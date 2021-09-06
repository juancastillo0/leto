import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:shelf_graphql/shelf_graphql.dart' show UploadedFileMeta;

import 'api_schema.dart';
// import 'graphql_ref_type.dart';

part 'file_event.freezed.dart';
part 'file_event.g.dart';

@freezed
class FileEvent with _$FileEvent {
  const FileEvent._();
  const factory FileEvent.added(
    UploadedFileMeta fileUpload, {
    @Default(true) bool replace,
  }) = FileEventAdded;
  const factory FileEvent.renamed({
    required String filename,
    required String newFilename,
    @Default(true) bool replace,
  }) = FileEventRenamed;
  const factory FileEvent.deleted(
    String filename,
  ) = FileEventDeleted;
  const factory FileEvent.many(
    List<FileEvent> events,
  ) = FileEventMany;

  factory FileEvent.fromJson(Map<String, Object?> json) =>
      _$FileEventFromJson(json);

  Set<String> editedFilenames() {
    return map(
      added: (added) => {added.fileUpload.filename},
      renamed: (renamed) => {renamed.filename, renamed.newFilename},
      deleted: (deleted) => {deleted.filename},
      many: (many) {
        return many.events
            .map((d) => d.editedFilenames())
            .reduce((value, other) => value.union(other));
      },
    );
  }
}

GraphQLUnionType<FileEvent>? _fileEventType;
GraphQLUnionType<FileEvent> fileEventType() {
  final typeDiscriminator = field<String, String, FileEvent>(
    'runtimeType',
    enumTypeFromStrings('FileEventType', [
      'added',
      'renamed',
      'deleted',
      'many',
    ]),
  );
  return _fileEventType ??= GraphQLUnionType(
    'FileEvent',
    [
      objectType(
        'FileEventAdded',
        fields: [
          typeDiscriminator,
          field(
            'fileUpload',
            fileUploadType().nonNullable(),
          ),
        ],
      ),
      objectType(
        'FileEventRenamed',
        fields: [
          typeDiscriminator,
          graphQLString.field(
            'filename',
            nullable: false,
          ),
          graphQLString.field(
            'newFilename',
            nullable: false,
          ),
        ],
      ),
      objectType(
        'FileEventDeleted',
        fields: [
          typeDiscriminator,
          graphQLString.field(
            'filename',
            nullable: false,
          ),
        ],
      ),
      objectType(
        'FileEventMany',
        fields: [
          typeDiscriminator,
          field(
            'events',
            listOf(refType(fileEventType)),
          ),
          field(
            'size',
            graphQLInt.nonNullable(),
            resolve: (event, ctx) {
              return (event as FileEventMany).events.length;
            },
          ),
        ],
      ),
    ],
  );
}
