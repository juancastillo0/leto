import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:leto_shelf/leto_shelf.dart' show UploadedFileMeta;

import 'file_upload.dart';

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
  if (_fileEventType != null) return _fileEventType!;
  _fileEventType = GraphQLUnionType(
    'FileEvent',
    [],
  );

  final typeDiscriminator = field<String, String, FileEvent>(
    'runtimeType',
    enumTypeFromStrings('FileEventType', [
      'added',
      'renamed',
      'deleted',
      'many',
    ]),
  );
  _fileEventType!.possibleTypes.addAll(<GraphQLObjectType<FileEvent>>[
    objectType(
      'FileEventAdded',
      fields: [
        typeDiscriminator,
        field(
          'fileUpload',
          fileUploadType().nonNull(),
        ),
      ],
    ),
    objectType(
      'FileEventRenamed',
      fields: [
        typeDiscriminator,
        graphQLString.nonNull().field('filename'),
        graphQLString.nonNull().field('newFilename'),
      ],
    ),
    objectType(
      'FileEventDeleted',
      fields: [
        typeDiscriminator,
        graphQLString.nonNull().field('filename'),
      ],
    ),
    objectType(
      'FileEventMany',
      fields: [
        typeDiscriminator,
        field(
          'events',
          listOf(fileEventType()),
        ),
        field(
          'size',
          graphQLInt.nonNull(),
          resolve: (event, ctx) {
            return (event as FileEventMany).events.length;
          },
        ),
      ],
    ),
  ]);

  return fileEventType();
}
