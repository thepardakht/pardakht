import 'package:pardakht/src/blocs/verification_bloc.dart';

import 'src/blocs/user_bloc.dart';
import 'src/blocs/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/repositories/pardakht_gateway.dart';
import 'src/blocs/auth_bloc.dart';

class PardakhtDataProvider extends StatelessWidget {
  final PardakhtRepository gateway;
  final Widget child;
  const PardakhtDataProvider({
    super.key,
    required this.gateway,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: gateway,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (c) => AuthBloc(
              pardakhtGateway: c.read<PardakhtRepository>(),
            ),
          ),
          BlocProvider(
            create: (c) => UserBloc(
              gateway: c.read<PardakhtRepository>(),
              authBloc: c.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (c) => UsersBloc(
              gateway: c.read<PardakhtRepository>(),
              authBloc: c.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (c) => VerificationBloc(
              authState: c.read<AuthBloc>().state,
              pardakhtGateway: c.read<PardakhtRepository>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
