import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markup_text/flutter_markup_text.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';
import 'package:pardakht/src/blocs/states/auth_state.dart';

import 'package:pardakht/src/views/components/text_field_verification_code.dart';

class ScreenVerification extends StatelessWidget {
  const ScreenVerification({super.key});

  void _sendVerifyCodeHandler(BuildContext context) {
    context.read<AuthBloc>().sendEmailVerificationCode(
        context.read<AuthBloc>().state.user.id ?? "");
  }

  String? _validator(BuildContext context, AuthState state) {
    return state.error;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = Text(
      "Email Verification",
      style: theme.textTheme.displaySmall,
    );
    final markupText = MarkupText(
      text: "Don'e Recieve the Code? @{Resend}",
      marks: [
        Mark(
          "Resend",
          () => _sendVerifyCodeHandler(context),
        )
      ],
    );
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final textFieldVerificationCode = TextFieldVerificationCode(
          onCompleted: (v) => context
              .read<AuthBloc>()
              .verifyEmail(context.read<AuthBloc>().state.user.id ?? "", v),
          validator: (value) => _validator(context, state),
        );
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title,
                textFieldVerificationCode,
                state.status.isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : markupText,
              ],
            ),
          ),
        );
      },
    );
  }
}
