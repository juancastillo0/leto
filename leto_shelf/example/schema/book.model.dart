import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.model.g.dart';

@JsonSerializable()
class BookAdded {
  final Book book;

  const BookAdded({
    required this.book,
  });

  factory BookAdded.fromJson(Map<String, Object?> json) =>
      _$BookAddedFromJson(json);
  Map<String, Object?> toJson() => _$BookAddedToJson(this);

  @override
  String toString() {
    return 'BookAdded${toJson()}';
  }
}

@JsonSerializable()
class Book {
  final String name;
  final DateTime publicationDate;
  final bool isFavourite;

  const Book({
    required this.name,
    required this.publicationDate,
    required this.isFavourite,
  });

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);
  Map<String, Object?> toJson() => _$BookToJson(this);

  @override
  String toString() {
    return 'Book${toJson()}';
  }
}
