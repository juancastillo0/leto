import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

/// type PageInfo {
///   hasNextPage: Boolean!
///   hasPreviousPage: Boolean!
///   startCursor: String
///   endCursor: String
/// }
final pageInfoGraphQLType = objectType<PageInfo>(
  'PageInfo',
  description: 'GraphQL pagination',
  fields: [
    graphQLBoolean.nonNull().field(
      'hasNextPage',
      resolve: (pageInfo, _) {
        return pageInfo.hasNextPage;
      },
    ),
    graphQLBoolean.nonNull().field(
      'hasPreviousPage',
      resolve: (pageInfo, _) {
        return pageInfo.hasPreviousPage;
      },
    ),
    graphQLString.field(
      'startCursor',
      resolve: (pageInfo, _) {
        return pageInfo.startCursor;
      },
    ),
    graphQLString.field(
      'endCursor',
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
}
