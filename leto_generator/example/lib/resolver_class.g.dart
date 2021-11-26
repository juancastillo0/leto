// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolver_class.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<String, Object, Object> queryInClassGraphQLField =
    field(
  'queryInClass',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver r) => r.queryInClass(ctx);
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver> _obj = Resolver();
    if (_obj is Future<Resolver>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);

final GraphQLObjectField<String, Object, Object> mutationInClassGraphQLField =
    field(
  'mutationInClass',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call =
        (Resolver r) => r.mutationInClass((args["values"] as List<int?>));
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver> _obj = Resolver();
    if (_obj is Future<Resolver>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
  inputs: [
    graphQLInt.list().nonNull().coerceToInputObject().inputField(
          "values",
        )
  ],
);

final GraphQLObjectField<String, Object, Object> queryInClass2GraphQLField =
    field(
  'queryInClass2',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver2 r) => r.queryInClass2();
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver2> _obj = instance2;
    if (_obj is Future<Resolver2>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);

final GraphQLObjectField<String, Object, Object> queryInClass3GraphQLField =
    field(
  'queryInClass3',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver3 r) => r.queryInClass3(ctx);
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver3> _obj = Resolver3.ref.get(ctx)!;
    if (_obj is Future<Resolver3>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);

final GraphQLObjectField<String, Object, Object> queryInClass4GraphQLField =
    field(
  'queryInClass4',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver4 r) => r.queryInClass4(ctx);
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver4> _obj = Resolver4.ref.get(ctx)!;
    if (_obj is Future<Resolver4>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);

final GraphQLObjectField<String, Object, Object> queryInClass5GraphQLField =
    field(
  'queryInClass5',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver5 r) => r.queryInClass5(ctx);
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver5> _obj = (_mapToType[Resolver5]! as Resolver5);
    if (_obj is Future<Resolver5>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);

final GraphQLObjectField<String, Object, Object> queryInClass6GraphQLField =
    field(
  'queryInClass6',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    final _call = (Resolver6 r) => r.queryInClass6();
    // ignore: unnecessary_non_null_assertion
    final FutureOr<Resolver6> _obj =
        _mapToRef[Resolver6]!.get(ctx) as FutureOr<Resolver6>;
    if (_obj is Future<Resolver6>)
      return _obj.then(_call);
    else
      return _call(_obj);
  },
);
