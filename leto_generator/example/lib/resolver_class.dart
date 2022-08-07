// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:leto_schema/leto_schema.dart';

part 'resolver_class.g.dart';

const schemaStrClassResolvers = [
  '''
  queryInClass: String!''',
  '''
  mutationInClass(values: [Int]!): String!''',
  '''
  queryInClass2: String!''',
  '''
  queryInClass3: String!''',
  '''
  queryInClass4: String!''',
  '''
  queryInClass5: String!''',
  '''
  queryInClass6: String!''',
];

@ClassResolver(instantiateCode: 'Resolver()')
class Resolver {
  @Query()
  String queryInClass(Ctx ctx) {
    return this.hashCode.toString();
  }

  @Mutation()
  String mutationInClass(List<int?> values) {
    return '';
  }
}

final instance2 = Resolver2();

@ClassResolver(instantiateCode: 'instance2')
class Resolver2 {
  @Query()
  String queryInClass2() {
    return this.hashCode.toString();
  }
}

@ClassResolver()
class Resolver3 {
  @Query()
  String queryInClass3(Ctx ctx) {
    return this.hashCode.toString();
  }

  static final ref = ScopedRef.scoped((_) => Resolver3());
}

@ClassResolver()
class Resolver4 {
  @Query()
  String queryInClass4(Ctx ctx) {
    return this.hashCode.toString();
  }

  static final ref = ScopedRef.global((_) => Resolver4());
}

final _mapToType = <Type, Object>{
  Resolver5: Resolver5(),
};

// ignore: constant_identifier_names
const DIByType = ClassResolver(
  instantiateCode: '(_mapToType[{{name}}]! as {{name}})',
);

@DIByType
class Resolver5 {
  @Query()
  String queryInClass5(Ctx ctx) {
    return this.hashCode.toString();
  }
}

late final _mapToRef = <Type, ScopedRef>{
  Resolver6: refResolver6,
};

// ignore: constant_identifier_names
const DIByRef = ClassResolver(
  instantiateCode: '_mapToRef[{{name}}]!.get(ctx).value as FutureOr<{{name}}>',
);

@DIByRef
class Resolver6 {
  @Query()
  String queryInClass6() {
    print('s ${refResolver6.hashCode}');
    return this.hashCode.toString();
  }
}

final refResolver6 = ScopedRef.global(
  (_) => MutableValue(Future.value(Resolver6())),
);
