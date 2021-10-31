import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:leto_shelf/src/graphql_ui/playground_css.dart';

import 'playground_config.dart';

export 'playground_config.dart';

Handler playgroundHandler({PlaygroundConfig? config}) {
  return (request) {
    return Response.ok(
      makePlaygroundHtml(config: config),
      headers: {HttpHeaders.contentTypeHeader: 'text/html'},
    );
  };
}

String makePlaygroundHtml({PlaygroundConfig? config}) {
  return '''
<!DOCTYPE html>

<html>

<head>
  <meta charset=utf-8 />
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, minimal-ui">
  <title>GraphQL Playground</title>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/graphql-playground-react/build/static/css/index.css" />
  <link rel="shortcut icon" href="//cdn.jsdelivr.net/npm/graphql-playground-react/build/favicon.png" />
  <script src="//cdn.jsdelivr.net/npm/graphql-playground-react/build/static/js/middleware.js"></script>

</head>

<body>
  $playgroundCss

  <div id="root" />
  <script type="text/javascript">
    window.addEventListener('load', function (event) {

      const loadingWrapper = document.getElementById('loading-wrapper');
      loadingWrapper.classList.add('fadeOut');


      const root = document.getElementById('root');
      root.classList.add('playgroundIn');
      
      const config = JSON.parse('${jsonEncode(config?.toJson() ?? const <String, Object?>{})}');
      GraphQLPlayground.init(root, config);
    })
  </script>
</body>
</html>
''';
}
