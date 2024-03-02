import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';
import 'package:pardakht/src/views/components/text_form_field.dart';

class FormConnectWallet extends StatelessWidget {
  FormConnectWallet({super.key});

  final _key = GlobalKey<FormState>();

  void _submitHandler(BuildContext context) {
    final state = _key.currentState;
    if (state?.validate() == true) {
      state?.save();
      context.read<AuthBloc>().signInWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = Text(
      "Welcom Back.",
      style: theme.textTheme.displaySmall,
    );
    final emailField = AppTextFormField(
      label: "Username | Email",
      onSaved: context.read<AuthBloc>().setLoginIdentification,
    );
    final passwordField = AppTextFormField(
      label: "Password",
      onSaved: context.read<AuthBloc>().setUserPassword,
    );
    final submitButton = ElevatedButton(
        onPressed: () => _submitHandler(context),
        child: const Text("Connect Wallet"));
    return Container(
      padding: const EdgeInsets.all(10),
      height: 300,
      child: Form(
          key: _key,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    title,
                    const SizedBox(height: 10),
                    emailField,
                    const SizedBox(height: 10),
                    passwordField,
                    const SizedBox(height: 10),
                    submitButton,
                  ],
                ),
              )
            ],
          )),
    );
  }
}
