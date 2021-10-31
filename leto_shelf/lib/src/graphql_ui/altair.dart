import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'altair_config.dart';

export 'altair_config.dart';

Handler altairHandler({
  AltairConfig config = const AltairConfig(),
}) {
  return (request) {
    return Response.ok(
      makeAltairHtml(config),
      headers: {HttpHeaders.contentTypeHeader: 'text/html'},
    );
  };
}

String makeAltairHtml(AltairConfig options) {
  final baseURL = options.baseURL ??
      'https://cdn.jsdelivr.net/npm/altair-static@4.0.9/build/dist/';

  if (options.serveInitialOptionsInSeperateRequest ?? false) {
    return altairHtmlBase
        .replaceFirst('<base href="./">', '<base href="$baseURL">')
        .replaceFirst(
            '</body>', '<script src="initial_options.js"></script></body>');
  } else {
    final initialOptions =
        "AltairGraphQL.init(JSON.parse('${jsonEncode(options.toJson())}'));";
    return altairHtmlBase
        .replaceFirst('<base href="./">', '<base href="$baseURL">')
        .replaceFirst('</body>', '<script>$initialOptions</script></body>');
  }
}

// altair-static 4.0.9
const altairHtmlBase = '''
<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <title>Altair</title>
  <base href="./">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="icon" type="image/x-icon" href="favicon.ico">
  <link href="styles.css" rel="stylesheet" />
</head>

<body>
  <app-root>
    <style>
      .loading-screen {
        /*Prevents the loading screen from showing until CSS is downloaded*/
        display: none;
      }

    </style>
    <div class="loading-screen styled">
      <div class="loading-screen-inner">
        <div class="loading-screen-logo-container">
          <img src="assets/img/logo_350.svg" alt="Altair">
        </div>
        <div class="loading-screen-loading-indicator">
          <span class="loading-indicator-dot"></span>
          <span class="loading-indicator-dot"></span>
          <span class="loading-indicator-dot"></span>
        </div>
      </div>
    </div>
  </app-root>
  <script rel="preload" as="script" type="text/javascript" src="runtime-es2018.js"></script>
  <script rel="preload" as="script" type="text/javascript" src="polyfills-es2018.js"></script>
  <script rel="preload" as="script" type="text/javascript" src="main-es2018.js"></script>
</body>

</html>
''';
