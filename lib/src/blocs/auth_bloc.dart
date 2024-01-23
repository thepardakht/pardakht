import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/interfaces/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'states/auth_state.dart';
import 'package:http/http.dart' as http;

class AuthBloc extends Cubit<AuthState> {
  final PardakhtGateway _gateway;
  AuthBloc({required PardakhtGateway pardakhtGateway})
      : _gateway = pardakhtGateway,
        super(const AuthState.init());

  void signInWithEmail() {}

  void signinWithPhone() {}

  void signInWithFacebook() {}

  void signinWithGoogle() {}

  void signinWithApple() {}

  void fetch() {}

  Future<void> authorize() async {
    emit(state.loadingState(AuthStateStatus.authorizing));
    try {
      _gateway.authorize().listen((user) {
        emit(
          state.successState(
            AuthStateStatus.authorize,
            user: user,
          ),
        );
      });
    } catch (error) {
      emit(state.failureState(AuthStateStatus.failedAuthorize, error: error));
    }
  }
}
