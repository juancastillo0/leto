// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickstart_server.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<Model?, Object?, Object?> get getStateGraphQLField =>
    _getStateGraphQLField.value;
final _getStateGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<Model?, Object?, Object?>>(
        (setValue) => setValue(modelGraphQLType.field<Object?>(
              'getState',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getState(ctx);
              },
              description:
                  r"Code Generation\nUsing leto_generator, [makeGraphQLSchema] could be generated\nwith the following annotated functions and the [GraphQLClass]\nannotation over [Model]\nGet the current state",
            )));

GraphQLObjectField<bool, Object?, Object?> get setStateGraphQLField =>
    _setStateGraphQLField.value;
final _setStateGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<bool, Object?, Object?>>(
        (setValue) => setValue(graphQLBoolean.nonNull().field<Object?>(
              'setState',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return setState(ctx, (args["newState"] as String));
              },
            ))
              ..inputs.addAll([
                graphQLString.nonNull().inputField('newState',
                    description: 'The new state, can\'t be \'WrongState\'!.')
              ]));

GraphQLObjectField<Model, Object?, Object?> get onStateChangeGraphQLField =>
    _onStateChangeGraphQLField.value;
final _onStateChangeGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<Model, Object?, Object?>>(
        (setValue) => setValue(modelGraphQLType.nonNull().field<Object?>(
              'onStateChange',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                return onStateChange(ctx);
              },
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _modelGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Model>>((setValue) {
  final __name = 'Model';

  final __modelGraphQLType =
      objectType<Model>(__name, isInterface: false, interfaces: []);

  setValue(__modelGraphQLType);
  __modelGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('state', resolve: (obj, ctx) => obj.state),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __modelGraphQLType;
});

/// Auto-generated from [Model].
GraphQLObjectType<Model> get modelGraphQLType => _modelGraphQLType.value;
