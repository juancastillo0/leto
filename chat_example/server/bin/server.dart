import 'package:server/handler.dart';
import 'package:shelf_plus/shelf_plus.dart';

Future<void> main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  // final ip = InternetAddress.anyIPv4;

  return runServer();
}

Future<void> runServer() async {
  await shelfRun(
    serverHandler,
    defaultBindPort: 8060,
    defaultBindAddress: '0.0.0.0',
    defaultEnableHotReload: true,
  );
}
