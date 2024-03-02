import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/user.dart';

import 'states/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final PardakhtRepository _gateway;
  AuthBloc({required PardakhtRepository pardakhtGateway})
      : _gateway = pardakhtGateway,
        super(const AuthState.init());

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
    _gateway
        .connectUser(state.user)
        .then(
          (value) => emit(
            state.successState(AuthStateStatus.connected),
          ),
        )
        .onError(
          (error, stackTrace) => emit(
            state.failureState(AuthStateStatus.failedConnect, error: error),
          ),
        );
  }

  StreamSubscription<User>? _authSub;
  void fetchUser(String? id) async {
    if (id == null) return;
    try {
      emit(state.loadingState(AuthStateStatus.streaming));
      await _authSub?.cancel();
      _authSub = _gateway.fetchCurrentUser().listen((user) {
        emit(
          state.successState(AuthStateStatus.streamed,
              user: state.user, isConnected: true),
        );
      },
          onError: (err) => emit(state
              .failureState(AuthStateStatus.failedStream, error: ('$err'))));
    } catch (err) {
      emit(state.failureState(AuthStateStatus.failedStream, error: ('$err')));
    }
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();

    return super.close();
  }
}
