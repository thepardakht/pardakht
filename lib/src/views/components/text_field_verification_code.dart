import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class TextFieldVerificationCode extends StatelessWidget {
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  const TextFieldVerificationCode(
      {super.key, this.onCompleted, this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: PinCodeTextField(
        validator: validator,
        appContext: context,
        useHapticFeedback: true,
        errorTextSpace: 20,
        length: 6,
        onCompleted: onCompleted,
      ),
    );
  }
}
