// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickstart_server.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<Model, Object, Object> getStateGraphQLField = field(
  'getState',
  modelGraphQLType,
  description:
      r"Code Generation\nUsing leto_generator, [makeGraphQLSchema] could be generated\nwith the following annotated functions and the [GraphQLClass]\nannotation over [Model]\nGet the current state",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getState(ctx);
  },
);

final GraphQLObjectField<bool, Object, Object> setStateGraphQLField = field(
  'setState',
  graphQLBoolean.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return setState(ctx, (args["newState"] as String));
  },
  inputs: [
    graphQLString.nonNull().coerceToInputObject().inputField(
          "newState",
          description: r"The new state, can't be 'WrongState'!.",
        )
  ],
);

final GraphQLObjectField<Model, Object, Object> onStateChangeGraphQLField =
    field(
  'onStateChange',
  modelGraphQLType.nonNull(),
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onStateChange(ctx);
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<Model>? _modelGraphQLType;

/// Auto-generated from [Model].
GraphQLObjectType<Model> get modelGraphQLType {
  final __name = 'Model';
  if (_modelGraphQLType != null)
    return _modelGraphQLType! as GraphQLObjectType<Model>;

  final __modelGraphQLType =
      objectType<Model>('Model', isInterface: false, interfaces: []);

  _modelGraphQLType = __modelGraphQLType;
  __modelGraphQLType.fields.addAll(
    [
      field('state', graphQLString.nonNull(), resolve: (obj, ctx) => obj.state),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __modelGraphQLType;
}
