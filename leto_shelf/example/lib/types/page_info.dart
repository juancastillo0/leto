import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';

/// GraphQLType with the state of pagination
///
/// ```graphql
/// type PageInfo {
///   hasNextPage: Boolean!
///   hasPreviousPage: Boolean!
///   startCursor: String
///   endCursor: String
/// }
/// ```
final pageInfoGraphQLType = objectType<PageInfo>(
  'PageInfo',
  description: 'Information about pagination in a connection.',
  fields: [
    graphQLBoolean.nonNull().field(
      'hasNextPage',
      description: 'When paginating forwards, are there more items?',
      resolve: (pageInfo, _) {
        return pageInfo.hasNextPage;
      },
    ),
    graphQLBoolean.nonNull().field(
      'hasPreviousPage',
      description: 'When paginating backwards, are there more items?',
      resolve: (pageInfo, _) {
        return pageInfo.hasPreviousPage;
      },
    ),
    graphQLString.field(
      'startCursor',
      description: 'When paginating backwards, the cursor to continue.',
      resolve: (pageInfo, _) {
        return pageInfo.startCursor;
      },
    ),
    graphQLString.field(
      'endCursor',
      description: 'When paginating forwards, the cursor to continue.',
      resolve: (pageInfo, _) {
        return pageInfo.endCursor;
      },
    ),
  ],
);

@immutable
class PageInfo {
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String? startCursor;
  final String? endCursor;

  const PageInfo({
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.startCursor,
    this.endCursor,
  });

  PageInfo copyWith({
    bool? hasNextPage,
    bool? hasPreviousPage,
    String? startCursor,
    String? endCursor,
  }) {
    return PageInfo(
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      startCursor: startCursor ?? this.startCursor,
      endCursor: endCursor ?? this.endCursor,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
      'startCursor': startCursor,
      'endCursor': endCursor,
    };
  }

  factory PageInfo.fromJson(Map<String, Object?> map) {
    return PageInfo(
      hasNextPage: map['hasNextPage']! as bool,
      hasPreviousPage: map['hasPreviousPage']! as bool,
      startCursor: map['startCursor'] as String?,
      endCursor: map['endCursor'] as String?,
    );
  }

  @override
  String toString() {
    return 'PageInfo(hasNextPage: $hasNextPage, hasPreviousPage: '
        '$hasPreviousPage, startCursor: $startCursor, endCursor: $endCursor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageInfo &&
        other.hasNextPage == hasNextPage &&
        other.hasPreviousPage == hasPreviousPage &&
        other.startCursor == startCursor &&
        other.endCursor == endCursor;
  }

  @override
  int get hashCode {
    return hasNextPage.hashCode ^
        hasPreviousPage.hashCode ^
        startCursor.hashCode ^
        endCursor.hashCode;
  }

  static GraphQLObjectType<PageInfo> get graphQLType => pageInfoGraphQLType;
}
