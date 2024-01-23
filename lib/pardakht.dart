import 'src/blocs/user_bloc.dart';
import 'src/blocs/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/interfaces/pardakht_gateway.dart';
import 'src/blocs/auth_bloc.dart';

class PardakhtDataProvider extends StatelessWidget {
  final PardakhtGateway gateway;
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
              pardakhtGateway: c.read<PardakhtGateway>(),
            ),
          ),
          BlocProvider(
            create: (c) => UserBloc(
              gateway: c.read<PardakhtGateway>(),
              authBloc: c.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (c) => UsersBloc(
              gateway: c.read<PardakhtGateway>(),
              authBloc: c.read<AuthBloc>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
