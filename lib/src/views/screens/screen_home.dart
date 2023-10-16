import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  static const String path = "/";
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
