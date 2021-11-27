// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickstart_server.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final getStateGraphQLField = modelGraphQLType.field<Object?>(
  'getState',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getState(ctx);
  },
  description:
      r"Code Generation\nUsing leto_generator, [makeGraphQLSchema] could be generated\nwith the following annotated functions and the [GraphQLClass]\nannotation over [Model]\nGet the current state",
);

final setStateGraphQLField = graphQLBoolean.nonNull().field<Object?>(
  'setState',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return setState(ctx, (args["newState"] as String));
  },
  inputs: [
    graphQLString.nonNull().coerceToInputObject().inputField('newState',
        description: 'The new state, can\'t be \'WrongState\'!.')
  ],
);

final onStateChangeGraphQLField = modelGraphQLType.nonNull().field<Object?>(
  'onStateChange',
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
      objectType<Model>(__name, isInterface: false, interfaces: []);

  _modelGraphQLType = __modelGraphQLType;
  __modelGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('state', resolve: (obj, ctx) => obj.state),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __modelGraphQLType;
}
