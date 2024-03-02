import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pardakht/src/blocs/auth_bloc.dart';
import 'package:pardakht/src/blocs/states/auth_state.dart';

import 'package:pardakht/src/views/forms/form_connect_wallet.dart';
import 'package:pardakht/src/views/screens/screen_error.dart';
import 'package:pardakht/src/views/screens/screen_loading.dart';
import 'package:pardakht/src/views/screens/screen_verify_email.dart';

class ScreenAuthentication extends StatefulWidget {
  static const String path = "/authentication";

  const ScreenAuthentication({super.key, this.token});

  final String? token;

  @override
  State<ScreenAuthentication> createState() => _ScreenAuthenticationState();
}

class _ScreenAuthenticationState extends State<ScreenAuthentication> {
  void _tryAgainHandler(BuildContext context) {
    context.read<AuthBloc>().toIdleState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status.isLoading) return const ScreenLoading();
        if (state.status.isFailure) {
          return ScreenError(
            state.error,
            onTryAgain: () => _tryAgainHandler(context),
          );
        }
        if (state.status.isSuccess) return const ScreenVerification();
        return Scaffold(
          body: Center(
            child: Container(
              width: 512,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FormConnectWallet(),
            ),
          ),
        );
      },
    );
  }
}
