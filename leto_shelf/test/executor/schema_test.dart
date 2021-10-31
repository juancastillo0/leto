// https://github.com/graphql/graphql-js/blob/8261922bafb8c2b5c5041093ce271bdfcdf133c3/src/execution/__tests__/schema-test.ts
import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

/// Execute: Handles execution with a complex schema
void main() {
  Map<String, Object?> getPic(int uid, int width, int height) {
    return {
      'url': 'cdn://${uid}',
      // TODO: graphql-js serializes into string
      'width': width,
      'height': height,
    };
  }

  Map<String, Object?> article(int id) {
    return {
      // TODO: graphql-js doesnt serialize into string
      'id': '$id',
      'isPublished': true,
      'author': {
        // TODO: graphql-js doesnt serialize into string
        'id': '123',
        'name': 'John Smith',
        'pic': (int width, int height) => getPic(123, width, height),
        'recentArticle': () => article(1),
      },
      'title': 'My Article $id',
      'body': 'This is a post',
      'hidden': 'This data is not exposed in the schema',
      // TODO: graphql-js doesnt serialize '1' and 'true' into string
      'keywords': ['foo', 'bar', '1', 'true', null],
    };
  }

  test('executes using a schema', () async {
    final blogImage = objectType<Object>(
      'Image',
      fields: [
        field('url', graphQLString),
        field('width', graphQLInt),
        field('height', graphQLInt),
      ],
    );

    final blogAuthor = objectType<Map<String, Object?>>(
      'Author',
    );

    final blogArticle = objectType<Object>(
      'Article',
      fields: [
        field('id', graphQLId.nonNull()),
        field('isPublished', graphQLBoolean),
        field('author', blogAuthor),
        field('title', graphQLString),
        field('body', graphQLString),
        field('keywords', listOf(graphQLString)),
      ],
    );

    blogAuthor.fields.addAll([
      field('id', graphQLString),
      field('name', graphQLString),
      blogImage.field(
        'pic',
        inputs: [
          GraphQLFieldInput('width', graphQLInt),
          GraphQLFieldInput('height', graphQLInt),
        ],
        resolve: (obj, ctx) => (obj['pic']! as Function(int, int))(
          ctx.args['width']! as int,
          ctx.args['height']! as int,
        ),
      ),
      field(
        'recentArticle',
        blogArticle,
        // resolve: (obj, _) => (obj['recentArticle']! as Function()).call(),
      ),
    ]);

    final blogQuery = objectType<Object>(
      'Query',
      fields: [
        field(
          'article',
          blogArticle,
          inputs: [
            GraphQLFieldInput('id', graphQLId),
          ],
          resolve: (_, ctx) => article(int.parse(ctx.args['id']! as String)),
        ),
        field(
          'feed',
          listOf(blogArticle),
          resolve: (_, __) => [
            article(1),
            article(2),
            article(3),
            article(4),
            article(5),
            article(6),
            article(7),
            article(8),
            article(9),
            article(10),
          ],
        ),
      ],
    );

    final blogSchema = GraphQLSchema(
      queryType: blogQuery,
    );

    const document = '''
      {
        feed {
          id,
          title
        },
        article(id: "1") {
          ...articleFields,
          author {
            id,
            name,
            pic(width: 640, height: 480) {
              url,
              width,
              height
            },
            recentArticle {
              ...articleFields,
              keywords
            }
          }
        }
      }
      fragment articleFields on Article {
        id,
        isPublished,
        title,
        body,
        hidden,
        notDefined
      }
    ''';

    // Note: this is intentionally not validating to ensure appropriate
    // behavior occurs when executing an invalid query.
    final result = await GraphQL(
      blogSchema,
      validate: false,
    ).parseAndExecute(document);
    expect(result.toJson(), {
      'data': {
        'feed': [
          {'id': '1', 'title': 'My Article 1'},
          {'id': '2', 'title': 'My Article 2'},
          {'id': '3', 'title': 'My Article 3'},
          {'id': '4', 'title': 'My Article 4'},
          {'id': '5', 'title': 'My Article 5'},
          {'id': '6', 'title': 'My Article 6'},
          {'id': '7', 'title': 'My Article 7'},
          {'id': '8', 'title': 'My Article 8'},
          {'id': '9', 'title': 'My Article 9'},
          {'id': '10', 'title': 'My Article 10'},
        ],
        'article': {
          'id': '1',
          'isPublished': true,
          'title': 'My Article 1',
          'body': 'This is a post',
          'author': {
            'id': '123',
            'name': 'John Smith',
            'pic': {
              'url': 'cdn://123',
              'width': 640,
              'height': 480,
            },
            'recentArticle': {
              'id': '1',
              'isPublished': true,
              'title': 'My Article 1',
              'body': 'This is a post',
              'keywords': ['foo', 'bar', '1', 'true', null],
            },
          },
        },
      },
    });
  });
}
