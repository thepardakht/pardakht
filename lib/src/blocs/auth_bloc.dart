import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(const AuthState.init());

  void signInWithEmail() {}

  void signinWithPhone() {}

  void signInWithFacebook() {}

  void signinWithGoogle() {}

  void signinWithApple() {}
}
