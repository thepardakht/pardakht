import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String label;

  const AppTextFormField({super.key, this.onSaved, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label),
      ),
      onSaved: onSaved,
    );
  }
}
