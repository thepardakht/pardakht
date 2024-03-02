import 'package:flutter/material.dart';

class ScreenError extends StatelessWidget {
  final String? message;
  final VoidCallback onTryAgain;
  const ScreenError(
    this.message, {
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message ?? "Some Error Accured! Please try again"),
            TextButton(
              onPressed: onTryAgain,
              child: const Text("Try again"),
            )
          ],
        ),
      ),
    );
  }
}
