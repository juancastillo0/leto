// https://github.com/graphql/graphql-js/blob/0c7165a5d0a7054cac4f2a0898ace19ca9d67f76/src/subscription/__tests__/subscribe-test.ts

import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

class Email {
  final String from;
  final String subject;
  final String message;
  final bool unread;

  Email({
    required this.from,
    required this.subject,
    required this.message,
    required this.unread,
  });

  Map<String, Object?> toJson() {
    return {
      'from': from,
      'subject': subject,
      'message': message,
      'unread': unread,
    };
  }

  factory Email.fromJson(Map<String, Object?> map) {
    return Email(
      from: map['from']! as String,
      subject: map['subject']! as String,
      message: map['message']! as String,
      unread: map['unread']! as bool,
    );
  }
}

final EmailType = GraphQLObjectType<Email>(
  'Email',
  fields: [
    field('from', graphQLString),
    field('subject', graphQLString),
    field('message', graphQLString),
    field('unread', graphQLBoolean),
  ],
);

class Inbox {
  final List<Email> emails;

  Inbox(this.emails);
}

final InboxType = GraphQLObjectType<Inbox>(
  'Inbox',
  fields: [
    graphQLInt.field(
      'total',
      resolve: (inbox, ctx) => inbox.emails.length,
    ),
    graphQLInt.field(
      'unread',
      resolve: (inbox, ctx) =>
          inbox.emails.where((email) => email.unread).length,
    ),
    listOf(EmailType).field(
      'emails',
      resolve: (inbox, _) => inbox.emails,
    ),
  ],
);

final QueryType = GraphQLObjectType<Object>(
  'Query',
  fields: [
    InboxType.field('inbox'),
  ],
);

final EmailEventType = GraphQLObjectType<Object>(
  'EmailEvent',
  fields: [
    field('email', EmailType),
    field('inbox', InboxType),
  ],
);

final emailSchema = GraphQLSchema(
  queryType: QueryType,
  subscriptionType: GraphQLObjectType(
    'Subscription',
    fields: [
      EmailEventType.field(
        'importantEmail',
        inputs: [
          GraphQLFieldInput('piority', graphQLInt),
        ],
      ),
    ],
  ),
);

Future<TestSubs> subscribe(
  GraphQLSchema schema, {
  required String document,
  Object? rootValue,
  Map<String, Object?>? variableValues,
}) async {
  final stream = await GraphQL(schema, validate: false)
      .parseAndExecute(
        document,
        rootValue: rootValue,
        variableValues: variableValues,
      )
      .then(
        (value) => value.subscriptionStream == null
            ? Stream.value(value)
            : value.subscriptionStream!,
      );
  return TestSubs(stream);
}

class TestSubs {
  final Stream<GraphQLResult> stream;
  bool done = false;
  int resolvedIndex = -1;
  int currentIndex = -1;
  final events = <Completer<Map<String, Object?>>>[];

  late final StreamSubscription<GraphQLResult> subs;

  // ignore: prefer_const_constructors
  final _closeResult = GraphQLResult(null);

  static const _doneEvent = {'done': true, 'value': null};

  TestSubs(this.stream) {
    subs = stream.listen(
      (event) {
        final index = ++resolvedIndex;
        getCompleter(index).complete(
          {
            'done': done && index == events.length - 1,
            'value': identical(event, _closeResult) ? null : event.toJson()
          },
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        final comp = getCompleter(++resolvedIndex);
        comp.completeError(
          error,
          stackTrace,
        );
      },
      onDone: () {
        done = true;
        close();
      },
    );
  }

  Completer<Map<String, Object?>> getCompleter(int index) {
    if (index >= events.length) {
      assert(index == events.length);
      events.add(Completer());
    }
    return events[index];
  }

  Future<Map<String, Object?>> throwErr(Object err) async {
    await close();

    return Future.error(err);
  }

  Future<Map<String, Object?>> next() async {
    if (done && currentIndex == events.length - 1) {
      return _doneEvent;
    }
    final comp = getCompleter(++currentIndex);
    return comp.future;
  }

  Future<Map<String, Object?>> singleValue() {
    return next().then(
      (value) {
        return value['value']! as Map<String, Object?>;
      },
    );
  }

  Future<Map<String, Object?>> close() async {
    await subs.cancel();
    done = true;
    for (final comp in events) {
      if (!comp.isCompleted) {
        comp.complete(_doneEvent);
      }
    }
    return _doneEvent;
  }
}

Future<TestSubs> createSubscription(StreamController<Email> pubsub) async {
  const document = r'''
    subscription ($priority: Int = 0) {
      importantEmail(priority: $priority) {
        email {
          from
          subject
        }
        inbox {
          unread
          total
        }
      }
    }
  ''';

  final emails = [
    Email(
      from: 'joe@graphql.org',
      subject: 'Hello',
      message: 'Hello World',
      unread: false,
    ),
  ];

  late final StreamController<Email> _controller;
  StreamSubscription<Email>? _subs;
  void _onListen() {
    _subs ??= pubsub.stream.listen((event) {
      emails.add(event);
      _controller.add(event);
    }, onDone: () async {
      await _controller.close();
    });
  }

  Future<void> _onCancel() async {
    return _subs?.cancel();
  }

  _controller = StreamController<Email>(
    onListen: _onListen,
    onCancel: _onCancel,
  );

  final inbox = Inbox(emails);
  final data = <String, Object?>{
    'inbox': inbox,
    'importantEmail': () => _controller.stream.map((newEmail) {
          return {
            'email': newEmail,
            'inbox': inbox,
          };
          // TODO: 3I was
          // return {
          //   'importantEmail': {
          //     'email': newEmail,
          //     'inbox': data.inbox,
          //   },
          // };
        })
  };

  return subscribe(emailSchema, document: document, rootValue: data);
  // return TestSubs(stream);
}

Future<FutReject> expectPromise(Future Function() promise) async {
  Object? caughtError;

  try {
    await promise();
    // istanbul ignore next (Shouldn't be reached)
    expect(true, false, reason: 'promise should have thrown but did not');
  } catch (error) {
    caughtError = error;
  }

  return FutReject(caughtError);
}

class FutReject {
  final Object? caughtError;

  FutReject(this.caughtError);

  void toReject() {
    expect(caughtError, const TypeMatcher<Exception>());
  }

  void toRejectWith(String message) {
    expect(caughtError, const TypeMatcher<Exception>());
    // TODO:
    expect((caughtError as dynamic).message, message);
  }
}

final DummyQueryType = GraphQLObjectType<Object>(
  'Query',
  fields: [
    graphQLString.field('dummy'),
  ],
);

void main() {
/* eslint-disable @typescript-eslint/require-await */
// Check all error cases when initializing the subscription.
  group('Subscription Initialization Phase', () {
    Stream<String?> fooGenerator() async* {
      yield 'FooValue';
      // TODO: was
      // yield { 'foo': 'FooValue' };
    }

    test('accepts multiple subscription fields defined in schema', () async {
      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: [
            field('foo', graphQLString),
            field('bar', graphQLString),
          ],
        ),
      );

      final subscription = await subscribe(
        schema,
        document: 'subscription { foo }',
        rootValue: {'foo': fooGenerator},
      );

      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'foo': 'FooValue'}
        },
      });

      // Close subscription
      await subscription.close();
    });

    test('accepts type definition with sync subscribe function', () async {
      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: [
            graphQLString.field(
              'foo',
              subscribe: (_, __) => fooGenerator(),
            ),
          ],
        ),
      );

      final subscription = await subscribe(
        schema,
        document: 'subscription { foo }',
      );

      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'foo': 'FooValue'}
        },
      });

      // Close subscription
      await subscription.close();
    });

    test('accepts type definition with async subscribe function', () async {
      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType('Subscription', fields: [
          graphQLString.field(
            'foo',
            subscribe: (_, __) {
              return Future.microtask(() => fooGenerator());
            },
          ),
        ]),
      );

      final subscription = await subscribe(
        schema,
        document: 'subscription { foo }',
      );

      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'foo': 'FooValue'}
        },
      });

      // Close subscription
      await subscription.close();
    });

    test('should only resolve the first field of invalid multi-field',
        () async {
      var didResolveFoo = false;
      var didResolveBar = false;

      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: [
            graphQLString.field(
              'foo',
              subscribe: (_, __) {
                didResolveFoo = true;
                return fooGenerator();
              },
            ),
            graphQLString.field(
              'bar',
              // istanbul ignore next (Shouldn't be called)
              subscribe: (_, __) {
                didResolveBar = true;
                throw Error();
              },
            ),
          ],
        ),
      );

      final subscription = await subscribe(
        schema,
        document: 'subscription { foo bar }',
      );

      expect(didResolveFoo, true);
      expect(didResolveBar, false);

      expect((await subscription.next())['done'], false);

      // Close subscription
      await subscription.close();
    });

    GraphQLSchema makeSchema(Object? Function() subscribe) => GraphQLSchema(
          queryType: DummyQueryType,
          subscriptionType: GraphQLObjectType(
            'Subscription',
            fields: [
              graphQLString.field('foo', subscribe: (_, __) {
                final out = subscribe();
                if (out is Stream) {
                  return out.cast();
                }
                return Stream.value(out as String?);
              }),
            ],
          ),
        );

    test('throws an error if some of required arguments are missing', () async {
      // TODO: const document = 'subscription { foo }';
      // final schema = makeSchema(() => null);

      /// The dart type signature does not allow these errors

      // @ts-expect-error (schema must not be null)
      // (await expectPromise(subscribe({ schema: null, document }))).toRejectWith(
      //   'Expected null to be a GraphQL schema.',
      // );

      // @ts-expect-error
      // (await expectPromise(subscribe({ document }))).toRejectWith(
      //   'Expected undefined to be a GraphQL schema.',
      // );

      // @ts-expect-error (document must not be null)
      // (await expectPromise(subscribe({ schema, document: null }))).toRejectWith(
      //   'Must provide document.',
      // );

      // @ts-expect-error
      // (await expectPromise(subscribe({ schema }))).toRejectWith(
      //   'Must provide document.',
      // );
    });

    test('resolves to an error for unknown subscription field', () async {
      const document = 'subscription { unknownField }';
      final schema = makeSchema(() => null);

      final result = await subscribe(schema, document: document);
      expect(await result.singleValue(), {
        'errors': [
          {
            'message': 'Subscription has no field named "unknownField".',
            'locations': [
              {'line': 0, 'column': 15}
            ],
          },
        ],
      });
    });

    test('should pass through unexpected errors thrown in subscribe', () async {
      // final schema = makeSchema(() => null);
      // // @ts-expect-error
      // (await expectPromise(() => subscribe(schema, document: {})
      //         .then<Object>((value) => value.singleValue())))
      //     .toReject();
    });

    test('throws an error if subscribe does not return an iterator', () async {
      // final schema = makeSchema(() => 'test');

      // const document = 'subscription { foo }';

      // (await expectPromise(() => subscribe(schema, document: document)))
      //     .toRejectWith(
      //   'Subscription field must return Async Iterable. Received: "test".',
      // );
    });

    test('resolves to an error for subscription resolver errors', () async {
      Future<TestSubs> subscribeWithFn(
          FutureOr<Stream<String?>> Function() subscribeFn) async {
        final schema = GraphQLSchema(
          queryType: DummyQueryType,
          subscriptionType: GraphQLObjectType(
            'Subscription',
            fields: [
              graphQLString.field('foo', subscribe: (_, __) => subscribeFn()),
            ],
          ),
        );
        const document = 'subscription { foo }';
        final result = await subscribe(schema, document: document);

        // TODO:
        // expect(await GraphQL(schema).createSourceEventStream(schema, document),
        //   result,
        // );
        return result;
      }

      const expectedResult = {
        'errors': [
          {
            'message': 'test error',
            'locations': [
              {'line': 0, 'column': 15}
            ],
            'path': ['foo'],
          },
        ],
      };

      // TODO:
      // expect(
      //   // Returning an error
      //   await subscribeWithFn(() => GraphQLError('test error')),
      // expectedResult);

      expect(
          // Throwing an error
          await (await subscribeWithFn(() {
            throw GraphQLError('test error');
          }))
              .singleValue(),
          expectedResult);

      // TODO:
      // expect(
      //   // Resolving to an error
      //   await subscribeWithFn(() => Future.value(GraphQLError('test error'))),
      // expectedResult);

      expect(
          // Rejecting with an error
          await (await subscribeWithFn(
                  () => Future.error(GraphQLError('test error'))))
              .singleValue(),
          expectedResult);
    });

    test('resolves to an error if variables were wrong type', () async {
      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: [
            field(
              'foo',
              graphQLString,
              inputs: [GraphQLFieldInput('arg', graphQLInt)],
            ),
          ],
        ),
      );

      const variableValues = {'arg': 'meow'};
      const document = r'''
      subscription ($arg: Int) {
        foo(arg: $arg)
      }
    ''';

      // If we receive variables that cannot be coerced correctly, subscribe() will
      // resolve to an ExecutionResult that contains an informative error description.
      final result = await subscribe(schema,
          document: document, variableValues: variableValues);
      expect(await result.singleValue(), {
        'errors': [
          {
            'message': stringContainsInOrder(['"arg"', 'integer', 'meow']),
            // r'Variable "$arg" got invalid value "meow"; Int cannot represent non-integer value: "meow"',
            'locations': [
              {'line': 0, 'column': 21}
            ],
          },
        ],
      });
    });
  });

// Once a subscription returns a valid AsyncIterator, it can still yield errors.
  group('Subscription Publish Phase', () {
    test('produces a payload for multiple subscribe in same subscription',
        () async {
      final pubsub = StreamController<Email>.broadcast();

      final subscription = await createSubscription(pubsub);

      final secondSubscription = await createSubscription(pubsub);

      final payload1 = subscription.next();
      final payload2 = secondSubscription.next();

      // expect(
      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright',
        message: 'Tests are good',
        unread: true,
      ));
      // ).to.equal(true);

      const expectedPayload = {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright',
              },
              'inbox': {
                'unread': 1,
                'total': 2,
              },
            },
          },
        },
      };

      expect(await payload1, expectedPayload);
      expect(await payload2, expectedPayload);
    });

    test('produces a payload per subscription event', () async {
      final pubsub = StreamController<Email>();
      final subscription = await createSubscription(pubsub);

      // Wait for the next subscription payload.
      final payload = subscription.next();

      // A new email arrives!
      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright',
        message: 'Tests are good',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      // The previously waited on payload now has a value.
      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright',
              },
              'inbox': {
                'unread': 1,
                'total': 2,
              },
            },
          },
        },
      });

      // Another new email arrives, before subscription.next() is called.

      pubsub.add(Email(
        from: 'hyo@graphql.org',
        subject: 'Tools',
        message: 'I <3 making things',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      // The next waited on payload will have a value.
      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'hyo@graphql.org',
                'subject': 'Tools',
              },
              'inbox': {
                'unread': 2,
                'total': 3,
              },
            },
          },
        },
      });

      // The client decides to disconnect.
      expect(await subscription.close(), {
        'done': true,
        'value': null,
      });

      // Which may result in disconnecting upstream services as well.

      pubsub.add(Email(
        from: 'adam@graphql.org',
        subject: 'Important',
        message: 'Read me please',
        unread: true,
      )); // No more listeners.
      expect(pubsub.hasListener, false);

      // Awaiting a subscription after closing it results in completed results.
      expect(await subscription.next(), {
        'done': true,
        'value': null,
      });
    });

    test('produces a payload when there are multiple events', () async {
      final pubsub = StreamController<Email>();
      final subscription = await createSubscription(pubsub);

      var payload = subscription.next();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright',
        message: 'Tests are good',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright',
              },
              'inbox': {
                'unread': 1,
                'total': 2,
              },
            },
          },
        },
      });

      payload = subscription.next();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright 2',
        message: 'Tests are good 2',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright 2',
              },
              'inbox': {
                'unread': 2,
                'total': 3,
              },
            },
          },
        },
      });
    });

    test('should not trigger when subscription is already done', () async {
      final pubsub = StreamController<Email>();
      final subscription = await createSubscription(pubsub);

      var payload = subscription.next();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright',
        message: 'Tests are good',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright',
              },
              'inbox': {
                'unread': 1,
                'total': 2,
              },
            },
          },
        },
      });

      payload = subscription.next();
      await subscription.close();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright 2',
        message: 'Tests are good 2',
        unread: true,
      ));
      expect(pubsub.hasListener, false);

      expect(await payload, {
        'done': true,
        'value': null,
      });
    });

    test('should not trigger when subscription is thrown', () async {
      final pubsub = StreamController<Email>();
      final subscription = await createSubscription(pubsub);

      var payload = subscription.next();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Alright',
        message: 'Tests are good',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Alright',
              },
              'inbox': {
                'unread': 1,
                'total': 2,
              },
            },
          },
        },
      });

      payload = subscription.next();

      // Throw error
      Object? caughtError;
      try {
        await subscription.throwErr('ouch');
      } catch (e) {
        caughtError = e;
      }
      expect(caughtError, 'ouch');

      expect(await payload, {
        'done': true,
        // TODO: 3T was undefined
        'value': null,
      });
    });

    test('event order is correct for multiple publishes', () async {
      final pubsub = StreamController<Email>.broadcast();
      final subscription = await createSubscription(pubsub);

      var payload = subscription.next();

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Message',
        message: 'Tests are good',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      // A new email arrives!

      pubsub.add(Email(
        from: 'yuzhi@graphql.org',
        subject: 'Message 2',
        message: 'Tests are good 2',
        unread: true,
      ));
      expect(pubsub.hasListener, true);

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Message',
              },
              'inbox': {
                'unread': 2,
                'total': 3,
              },
            },
          },
        },
      });

      payload = subscription.next();

      expect(await payload, {
        'done': false,
        'value': {
          'data': {
            'importantEmail': {
              'email': {
                'from': 'yuzhi@graphql.org',
                'subject': 'Message 2',
              },
              'inbox': {
                'unread': 2,
                'total': 3,
              },
            },
          },
        },
      });
    });

    test('should handle error during execution of source event', () async {
      Stream<String> generateMessages() async* {
        yield 'Hello';
        yield 'Goodbye';
        yield 'Bonjour';
      }

      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: {
            graphQLString.field(
              'newMessage',
              subscribe: (_, __) => generateMessages()
              // TODO: 1I support throwing in stream?
              // .map((message) {
              // if (message == 'Goodbye') {
              //   throw GraphQLError('Never leave.');
              // }
              // return message;
              // })
              ,
              // TODO:
              resolve: (event, _) {
                final message = (event as SubscriptionEvent).value as String?;
                if (message == 'Goodbye') {
                  throw GraphQLError('Never leave.');
                }
                return message;
              },
            ),
          },
        ),
      );

      const document = 'subscription { newMessage }';
      final subscription = await subscribe(schema, document: document);

      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'newMessage': 'Hello'},
        },
      });

      // An error in execution is presented as such.
      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'newMessage': null},
          'errors': [
            {
              'message': 'Never leave.',
              'locations': [
                {'line': 0, 'column': 15}
              ],
              'path': ['newMessage'],
            },
          ],
        },
      });

      // However that does not close the response event stream.
      // Subsequent events are still executed.
      expect(await subscription.next(), {
        'done': false,
        'value': {
          'data': {'newMessage': 'Bonjour'},
        },
      });
    });

    test('should pass through error thrown in source event stream', () async {
      Stream<String> generateMessages() async* {
        yield 'Hello';
        throw GraphQLError('test error');
      }

      final schema = GraphQLSchema(
        queryType: DummyQueryType,
        subscriptionType: GraphQLObjectType(
          'Subscription',
          fields: [
            graphQLString.field(
              'newMessage',
              // TODO:
              // resolve: (message, __) => message,
              subscribe: (_, __) => generateMessages(),
            ),
          ],
        ),
      );

      const document = 'subscription { newMessage }';
      final subscription = await subscribe(schema, document: document);

      final payload = await subscription.next();
      expect(payload, {
        'done': false,
        'value': {
          'data': {'newMessage': 'Hello'},
        },
      });

      final futMatcher = await expectPromise(() => subscription.next());
      futMatcher.toRejectWith('test error');

      expect(await subscription.next(), {
        'done': true,
        // TODO: was undefined
        'value': null,
      });
    });
  });
}
