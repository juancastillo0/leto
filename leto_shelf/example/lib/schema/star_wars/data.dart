import 'package:shelf_graphql_example/schema/star_wars/schema.dart';

/// These are types which correspond to the schema.
/// They represent the shape of the data visited during field resolution.
abstract class Character {
  String get id;
  String get name;
  List<String> get friends;
  List<int> get appearsIn;
}

// export interface Human {
//   type: "Human";
//   id: String;
//   name: String;
//   friends: List<String>;
//   appearsIn: List<int>;
//   homePlanet?: String;
// }

// export interface Droid {
//   type: "Droid";
//   id: String;
//   name: String;
//   friends: List<String>;
//   appearsIn: List<int>;
//   primaryFunction: String;
// }

/// This defines a basic set of data for our Star Wars Schema.
///
/// This data is hard coded for the sake of the demo, but you could imagine
/// fetching this data from a backend service rather than from hardcoded
/// JSON objects in a more complex demo.

const luke = Human(
  // type: "Human",
  id: '1000',
  name: 'Luke Skywalker',
  friends: ['1002', '1003', '2000', '2001'],
  appearsIn: [4, 5, 6],
  homePlanet: 'Tatooine',
);

const vader = Human(
  // type: "Human",
  id: '1001',
  name: 'Darth Vader',
  friends: ['1004'],
  appearsIn: [4, 5, 6],
  homePlanet: 'Tatooine',
);

const han = Human(
  // type: "Human",
  id: '1002',
  name: 'Han Solo',
  friends: ['1000', '1003', '2001'],
  appearsIn: [4, 5, 6],
);

const leia = Human(
  // type: "Human",
  id: '1003',
  name: 'Leia Organa',
  friends: ['1000', '1002', '2000', '2001'],
  appearsIn: [4, 5, 6],
  homePlanet: 'Alderaan',
);

const tarkin = Human(
  // type: "Human",
  id: '1004',
  name: 'Wilhuff Tarkin',
  friends: ['1001'],
  appearsIn: [4],
);

final humanData = {
  luke.id: luke,
  vader.id: vader,
  han.id: han,
  leia.id: leia,
  tarkin.id: tarkin,
};

const threepio = Droid(
  // type: "Droid",
  id: '2000',
  name: 'C-3PO',
  friends: ['1000', '1002', '1003', '2001'],
  appearsIn: [4, 5, 6],
  primaryFunction: 'Protocol',
);

const artoo = Droid(
  // type: "Droid",
  id: '2001',
  name: 'R2-D2',
  friends: ['1000', '1002', '1003'],
  appearsIn: [4, 5, 6],
  primaryFunction: 'Astromech',
);

final droidData = {
  threepio.id: threepio,
  artoo.id: artoo,
};

/// Helper function to get a character by ID.
Future<Character?> getCharacter(String id) {
  // Returning a promise just to illustrate that GraphQL.js supports it.
  return Future.value(humanData[id] ?? droidData[id]);
}

/// Allows us to query for a character's friends.
List<Future<Character?>> getFriends(Character character) {
  // Notice that GraphQL accepts Arrays of Promises.
  return character.friends.map((id) => getCharacter(id)).toList();
}

/// Allows us to fetch the undisputed hero of the Star Wars trilogy, R2-D2.
Character getHero(int? episode) {
  if (episode == 5) {
    // Luke is the hero of Episode V.
    return luke;
  }
  // Artoo is the hero otherwise.
  return artoo;
}

/// Allows us to query for the human with the given id.
Human? getHuman(String id) {
  return humanData[id];
}

/// Allows us to query for the droid with the given id.
Droid? getDroid(String id) {
  return droidData[id];
}
