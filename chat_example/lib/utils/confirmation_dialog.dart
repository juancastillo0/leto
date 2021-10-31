import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String text,
  String? acceptText,
  String? titleText,
  bool barrierDismissible = true,
}) async {
  final result = await showDialog<Object?>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(acceptText ?? 'Accept'),
          ),
        ],
      );
    },
  );
  return result == true;
}
