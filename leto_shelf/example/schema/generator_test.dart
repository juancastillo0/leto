import 'package:formgen/formgen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

part 'generator_test.freezed.dart';
part 'generator_test.g.dart';

@GraphQLClass()
@JsonSerializable()
@Validate()

/// Custom doc
class TestModel {
  @ValidateString(minLength: 1, maxLength: 64)
  final String name;

  /// Custom doc d
  final String? description;
  final List<DateTime>? dates;

  bool get hasDates => dates?.isNotEmpty ?? false;

  const TestModel({
    required this.name,
    this.description,
    this.dates,
  });
}

/// Custom doc
@GraphQLClass()
@freezed
class TestModelFreezed with _$TestModelFreezed {
  @JsonSerializable()
  const factory TestModelFreezed({
    required String name,

    /// Custom doc d
    String? description,
    List<DateTime>? dates,
  }) = _TestModelFreezed;
  const TestModelFreezed._();

  bool get hasDates => dates?.isNotEmpty ?? false;
}

@GraphQLClass()
@freezed
class EventUnion with _$EventUnion {
  @JsonSerializable()
  const factory EventUnion.add({
    required String name,
    // Custom doc d
    String? description,
    List<DateTime>? dates,
  }) = EventUnionAdd;
  const factory EventUnion.delete({
    String? name,
    List<DateTime>? dates,
  }) = EventUnionDelete;
  const EventUnion._();

  bool get hasDates => dates?.isNotEmpty ?? false;
}

/// the function uses [value] to do stuff
@Mutation()
TestModel? addTestModel(
  ReqCtx context,
  String realName, {
  TestModel? previous,
  @Deprecated('use realName') required String name,
  required List<int> value,
}) {
  return TestModel(
    name: 'Out',
    description: 'default',
  );
}

/// Automatic documentation generated
/// [position] is the pad
@Query()
List<TestModel> testModels(
  ReqCtx ctx,
  // pagination less than
  DateTime lessThan, {
  // pagination
  int position = 0,
}) {
  return [
    TestModel(
      name: 'Out',
      description: 'default',
    )
  ];
}

/// optional nullability based on annotations (not only on type system)
///   every where: return types, class fields, parameters
/// deprecationReason in params
/// default in frezzed an other annotations (union key)
/// nested Resolvers in classes (potentially empty classes)
/// nested Resolvers (Query, Mutation...) in libraries
/// pagination (types with generics)
/// 
/// Limit query complexity/depth
/// Batch Queries
/// persisted queries
/// apollo tracing
/// logging
/// other types uuid/url/Uri/duration/validation/json/decimal
/// dataloader