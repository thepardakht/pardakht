import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ButtonAuthentication extends StatelessWidget {
  const ButtonAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("authentication.button").tr(),
    );
  }
}
