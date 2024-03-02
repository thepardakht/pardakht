import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';

class ButtonAuthentication extends StatelessWidget {
  const ButtonAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // context.read<AuthBloc>().authorize();
      },
      child: const Text("authentication.button").tr(),
    );
  }
}
