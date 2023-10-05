import 'package:flutter/material.dart';
import 'package:pardakht/src/ui/components/button_authentication.dart';
import 'package:pardakht/src/ui/sections/slider_app_info.dart';

class ScreenAuthentication extends StatelessWidget {
  static const String path = "/authentication";
  const ScreenAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlidersAppInfo(),
          ButtonAuthentication(),
        ],
      ),
    ));
  }
}
