// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAdded _$BookAddedFromJson(Map<String, dynamic> json) => BookAdded(
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookAddedToJson(BookAdded instance) => <String, dynamic>{
      'book': instance.book,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      name: json['name'] as String,
      publicationDate: DateTime.parse(json['publicationDate'] as String),
      isFavourite: json['isFavourite'] as bool,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'name': instance.name,
      'publicationDate': instance.publicationDate.toIso8601String(),
      'isFavourite': instance.isFavourite,
    };
