import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:valida/valida.dart';

part 'generator_test.freezed.dart';
part 'generator_test.g.dart';

@visibleForTesting
final testUnionModelsTestKey = ScopeRef<List<EventUnion?>>('testUnionModels');

/// Custom doc
@GraphQLClass()
@JsonSerializable()
@Valida()
class TestModel {
  @ValidaString(minLength: 1, maxLength: 64)
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

  factory TestModel.fromJson(Map<String, Object?> json) =>
      _$TestModelFromJson(json);
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
  const factory EventUnion.add({
    required String name,
    // Custom doc d
    String? description,
    List<DateTime>? dates,
    required List<TestModel?> models,
  }) = _EventUnionAdd;
  const factory EventUnion.delete({
    String? name,
    required int cost,
    List<DateTime>? dates,
  }) = EventUnionDelete;
  const EventUnion._();

  factory EventUnion.fromJson(Map<String, Object?> json) =>
      _$EventUnionFromJson(json);

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

/// testUnionModels documentation generated
/// [position] is the pad
@Query()
List<EventUnion?> testUnionModels(
  ReqCtx ctx, {
  // pagination
  List<int?> positions = const [],
}) {
  final response = testUnionModelsTestKey.get(ctx);
  if (response != null) {
    return response;
  }
  return [
    null,
    EventUnion.add(
      name: 'da',
      models: [
        null,
        TestModel(name: 'da test', description: 'dda'),
      ],
    ),
    EventUnion.delete(
      name: 'da',
      cost: 24,
      dates: [DateTime(2021, 2, 4)],
    ),
  ];
}

/// optional nullability based on annotations (not only on type system)
///   everywhere: return types, class fields, parameters
/// deprecationReason in params
/// default in frezzed an other annotations (union key)
/// nested Resolvers in classes (potentially empty classes)
/// nested Resolvers (Query, Mutation...) in libraries
/// pagination (types with generics)
/// 
/// Limit query complexity/depth
/// persisted queries
/// logging
/// other types uuid/url/Uri/duration/validation/json/decimal
/// 
/// execution https://github.com/graphql/graphql-js/tree/main/src/execution/__tests__
/// subscription https://github.com/graphql/graphql-js/tree/main/src/subscription/__tests__
/// type https://github.com/graphql/graphql-js/tree/main/src/type/__tests__
/// valueFromAST https://github.com/graphql/graphql-js/blob/main/src/utilities/valueFromAST.ts
/// 
