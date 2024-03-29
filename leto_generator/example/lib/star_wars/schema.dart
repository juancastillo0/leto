// https://github.com/graphql/graphql-js/blob/2df59f18dd3f3c415eaba57d744131a674079ddf/src/__tests__/starWarsSchema.ts

/**
 * This is designed to be an end-to-end test, demonstrating
 * the full GraphQL stack.
 *
 * We will create a GraphQL schema that describes the major
 * characters in the original Star Wars trilogy.
 *
 * NOTE: This may contain spoilers for the original Star
 * Wars trilogy.
 */

/// Using our shorthand to describe type systems, the type system for our
/// Star Wars example is:
///
/// ```graphql
/// enum Episode { NEW_HOPE, EMPIRE, JEDI }
///
/// interface Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
/// }
///
/// type Human implements Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
///   homePlanet: String
/// }
///
/// type Droid implements Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
///   primaryFunction: String
/// }
///
/// type Query {
///   hero(episode: Episode): Character
///   human(id: String!): Human
///   droid(id: String!): Droid
/// }
/// ```
///
/// We begin by setting up our schema.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'data.dart';

part 'schema.freezed.dart';
part 'schema.g.dart';

/// The original trilogy consists of three movies.
///
/// This implements the following type system shorthand:
/// ```graphql
/// enum Episode { NEW_HOPE, EMPIRE, JEDI }
/// ```
final episodeEnum = GraphQLEnumType(
  'Episode',
  const [
    GraphQLEnumValue('NEW_HOPE', 4, description: 'Released in 1977.'),
    GraphQLEnumValue('EMPIRE', 5, description: 'Released in 1980.'),
    GraphQLEnumValue('JEDI', 6, description: 'Released in 1983.'),
  ],
  description: 'One of the films in the Star Wars Trilogy',
);

/// Characters in the Star Wars trilogy are either humans or droids.
///
/// This implements the following type system shorthand:
/// ```graphql
/// interface Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
///   secretBackstory: String
/// }
/// ```
// TODO: 1I GraphQLInterfaceType
GraphQLObjectType<Character>? _characterInterface;
GraphQLObjectType<Character> characterInterface() {
  if (_characterInterface != null) return _characterInterface!;
  _characterInterface = objectType(
    'Character',
    description: 'A character in the Star Wars Trilogy',
    isInterface: true,
    fields: [
      graphQLId.nonNull().field(
            'id',
            description: 'The id of the character.',
          ),
      graphQLString.field(
        'name',
        description: 'The name of the character.',
      ),
      listOf(episodeEnum).field(
        'appearsIn',
        description: 'Which movies they appear in.',
      ),
      graphQLString.field(
        'secretBackstory',
        description: 'All secrets about their past.',
      ),
    ],
    // resolveType(character) {
    //   switch (character.type) {
    //     case 'Human':
    //       return humanType.name;
    //     case 'Droid':
    //       return droidType.name;
    //   }
    // },
  );

  _characterInterface!.fields.add(
    listOf(characterInterface()).field(
      'friends',
      description:
          'The friends of the character, or an empty list if they have none.',
    ),
  );

  return characterInterface();
}

/// We define our human type, which implements the character interface.
///
/// This implements the following type system shorthand:
/// ```graphql
/// type Human : Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
///   secretBackstory: String
/// }
/// ```
@GraphQLObject(interfaces: ['characterInterface()'])
@freezed
class Human with _$Human implements Character {
  const factory Human({
    // The id of the human.
    required String id,
    // The name of the human.
    @GraphQLField(nullable: true) required String name,
    // Which movies they appear in.
    @GraphQLField(type: 'listOf(episodeEnum)') required List<int> appearsIn,
    // The friends of the human, or an empty list if they have none.
    @GraphQLField(omit: true) required List<String> friends,
    // The home planet of the human, or null if unknown.
    String? homePlanet,
  }) = _Human;

  const Human._();

  factory Human.fromJson(Map<String, Object?> json) => _$HumanFromJson(json);

  @GraphQLField(name: 'friends', type: 'listOf(characterInterface())')
  Future<List<Character?>?> get fetchFriends => Future.wait(getFriends(this));

  /// Where are they from and how they came to be who they are.
  String? get secretBackstory {
    throw GraphQLException.fromMessage('secretBackstory is secret.');
  }
}

/// The other type of character in Star Wars is a droid.
///
/// This implements the following type system shorthand:
/// ```graphql
/// type Droid : Character {
///   id: String!
///   name: String
///   friends: [Character]
///   appearsIn: [Episode]
///   secretBackstory: String
///   primaryFunction: String
/// }
/// ```
@GraphQLObject(interfaces: ['characterInterface()'])
@freezed
class Droid with _$Droid implements Character {
  /// A mechanical creature in the Star Wars universe.
  // ignore: invalid_annotation_target
  @JsonSerializable()
  const factory Droid({
    /// The id of the droid.
    required String id,
    @GraphQLField(nullable: true) required String name,
    @GraphQLField(omit: true) required List<String> friends,
    // Which movies they appear in.
    @GraphQLField(type: 'listOf(episodeEnum)') required List<int> appearsIn,
    // The primary function of the droid.
    @GraphQLField(nullable: true) required String primaryFunction,
  }) = _Droid;

  const Droid._();

  @GraphQLField(name: 'friends', type: 'listOf(characterInterface())')
  Future<List<Character?>?> get fetchFriends => Future.wait(getFriends(this));

  /// Construction date and the name of the designer.
  String? get secretBackstory {
    throw GraphQLException.fromMessage('secretBackstory is secret.');
  }
}

// const droidType = new GraphQLObjectType({
//   name: 'Droid',
//   description: 'A mechanical creature in the Star Wars universe.',
//   fields: () => ({
//     id: {
//       type: new GraphQLNonNull(GraphQLString),
//       description: 'The id of the droid.',
//     },
//     name: {
//       type: GraphQLString,
//       description: 'The name of the droid.',
//     },
//     friends: {
//       type: new GraphQLList(characterInterface),
//       description:
//         'The friends of the droid, or an empty list if they have none.',
//       resolve: (droid) => getFriends(droid),
//     },
//     appearsIn: {
//       type: new GraphQLList(episodeEnum),
//       description: 'Which movies they appear in.',
//     },
//     secretBackstory: {
//       type: GraphQLString,
//       description: 'Construction date and the name of the designer.',
//       resolve() {
//         throw new Error('secretBackstory is secret.');
//       },
//     },
//     primaryFunction: {
//       type: GraphQLString,
//       description: 'The primary function of the droid.',
//     },
//   }),
//   interfaces: [characterInterface],
// });

@Query()
Droid? droid(
  // id of the droid
  String id,
) {
  return getDroid(id);
}

/// This is the type that will be the root of our query, and the
/// entry point into our schema. It gives us the ability to fetch
/// objects by their IDs, as well as to fetch the undisputed hero
/// of the Star Wars trilogy, R2-D2, directly.
///
/// This implements the following type system shorthand:
/// ```graphql
/// type Query {
///   hero(episode: Episode): Character
///   human(id: String!): Human
///   droid(id: String!): Droid
/// }
/// ```
final queryType = objectType<Object?>(
  'Query',
  fields: [
    characterInterface().field(
      'hero',
      inputs: [
        GraphQLFieldInput(
          'episode',
          episodeEnum,
          description: 'If omitted, returns the hero of the whole saga. '
              'If provided, returns the hero of that particular episode.',
        ),
      ],
      resolve: (_source, ctx) => getHero(ctx.args['episode'] as int?),
    ),
    humanGraphQLType.field(
      'human',
      inputs: [
        GraphQLFieldInput(
          'id',
          graphQLId.nonNull(),
          description: 'id of the human',
        )
      ],
      resolve: (_source, ctx) => getHuman(ctx.args['id']! as String),
    ),

    /// Generated from the [droid] function
    droidGraphQLField,
    // droidGraphQlType.field(
    //   'droid',
    //   arguments: [
    //     GraphQLFieldInput(
    //       'id',
    //       graphQLString.nonNull(),
    //     )
    //   ],
    //   resolve: (obj, ctx) => getDroid(ctx.args['id']! as String),
    // ),
  ],
);

/// Finally, we construct our schema (whose starting query type is the query
/// type we defined above) and export it.
final starWarsSchema = GraphQLSchema(
  queryType: queryType,
  // types: [humanType, droidType],
);
