import 'package:flutter/material.dart';

class BoxError extends StatelessWidget {
  final String? message;
  final void Function()? onRetry;
  const BoxError({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("An error acurred: $message"),
        TextButton.icon(
            icon: const Icon(Icons.restart_alt),
            onPressed: onRetry,
            label: const Text("Try again"))
      ],
    );
  }
}
