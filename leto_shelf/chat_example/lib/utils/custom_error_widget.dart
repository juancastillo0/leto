import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.message,
    required this.refresh,
  }) : super(key: key);

  final String message;
  final void Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
        ElevatedButton.icon(
          onPressed: () {
            refresh();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
        )
      ],
    );
  }
}
