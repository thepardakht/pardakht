import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';

import 'states/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final PardakhtRepository _gateway;
  AuthBloc({required PardakhtRepository pardakhtGateway})
      : _gateway = pardakhtGateway,
        super(const AuthState.init()) {
    fetchCurrenAccount();
  }

  void toInitState() {
    emit(const AuthState.init());
  }

  void toIdleState() {
    emit(state.idleState());
  }

  void setLoginIdentification(String? value) {
    if (value == null) return;
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (emailRegex.hasMatch(value)) {
      final user = state.user.copyWith(email: value);
      emit(state.copyWith(user: user));
    } else {
      final user = state.user.copyWith(username: value);
      emit(state.copyWith(user: user));
    }
  }

  void setUserPassword(String? value) {
    if (value == null) return;
    final user = state.user.copyWith(password: value);
    emit(state.copyWith(user: user));
  }

  void signInWithEmail() {
    emit(state.loadingState(AuthStateStatus.connecting));
    _gateway.connectUser(state.user).then(
      (value) {
        final user = state.user.copyWith(id: value);
        emit(state.copyWith(user: user));
        _gateway.sendEmailVerificationCode(value);
        return emit(state.successState(AuthStateStatus.connected));
      },
    ).onError(
      (error, stackTrace) => emit(
        state.failureState(AuthStateStatus.failedConnect, error: error),
      ),
    );
  }

  void sendEmailVerificationCode(String userId) {
    emit(state.loadingState(AuthStateStatus.sendingEmailVerifactionCode));
    _gateway
        .sendEmailVerificationCode(userId)
        .then(
          (value) => emit(
              state.successState(AuthStateStatus.sendEmailVerificationCode)),
        )
        .onError((error, stackTrace) => emit(
              state.failureState(
                AuthStateStatus.failSendEmailVerificationCode,
                error: '$error',
              ),
            ));
  }

  void verifyEmail(String userId, String code) {
    emit(state.loadingState(AuthStateStatus.verifyingEmail));

    _gateway
        .verifyEmailVerificationCode(userId, code)
        .then(
          (value) {
            return emit(state.successState(AuthStateStatus.verifiedEmail,
                token: value));
          },
        )
        .onError(
          (error, stackTrace) => emit(
            state.failureState(
              AuthStateStatus.faildVerifyEmail,
              error: '$error',
            ),
          ),
        )
        .then((value) => fetchCurrenAccount());
  }

  StreamSubscription<void>? _accountSub;
  void fetchCurrenAccount() async {
    _accountSub = _gateway.fetchCurrentUser().listen((event) {
      if (event.id != null) {
        emit(state.successState(AuthStateStatus.streamed,
            user: event, isConnected: true));
      }
    }, onError: (err) {
      emit(state.failureState(AuthStateStatus.failedStream, error: ('$err')));
    });
  }

  @override
  Future<void> close() async {
    await _accountSub?.cancel();
    return super.close();
  }
}
