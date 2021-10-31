import 'dart:convert' show base64UrlEncode;

import 'package:uuid/uuid.dart' show Uuid;

String uuidBase64Url() {
  final uuidBytes = const Uuid().v4obj().toBytes();
  final uuidPadded = base64UrlEncode(uuidBytes);
  final uuid = uuidPadded.replaceAll('=', '');
  return uuid;
}
