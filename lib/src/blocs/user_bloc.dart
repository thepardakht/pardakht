import '../domain/enums/user_role.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/pardakht_gateway.dart';
import '../domain/entities/user.dart';
import 'states/user_state.dart';
import 'states/auth_state.dart';
import 'auth_bloc.dart';

class UserBloc extends Cubit<UserState> {
  StreamSubscription<AuthState>? _authSub;
  final PardakhtRepository _gateway;
  UserBloc({
    required PardakhtRepository gateway,
    required AuthBloc authBloc,
  })  : _gateway = gateway,
        super(const UserState.init()) {
    _authSub = authBloc.stream.listen((event) {
      emit(state.fetchedState(currentUser: event.user));
    }, onError: (err) => emit(state.failedFetchState('$err')));
  }

  void setUser(User? user) {
    if (user == null) return;
    emit(state.copyWith(user: user));
  }

  void setUserId(String? id) {
    if (id == null) return;
    final user = state.user.copyWith(id: id);
    emit(state.copyWith(user: user));
  }

  void setUserName(String? name) {
    if (name == null) return;
    final user = state.user.copyWith(name: name);
    emit(state.copyWith(user: user));
  }

  void setUserEmail(String? email) {
    if (email == null) return;
    final user = state.user.copyWith(email: email);
    emit(state.copyWith(user: user));
  }

  void setUserPassword(String? password) {
    if (password == null) return;
    final user = state.user.copyWith(password: password);
    emit(state.copyWith(user: user));
  }

  void setUserRole(UserRole? role) {
    if (role == null) return;
    final user = state.user.copyWith(role: role);
    emit(state.copyWith(user: user));
  }

  void createUser() async {
    try {
      emit(state.creatingState());
      await _gateway.createUser(state.user);
      emit(state.createdState());
    } catch (err) {
      emit(state.failedCreateState('$err'));
    }
  }

  StreamSubscription<User>? _userSub;
  void fetchUser(String? id) async {
    if (id == null) return;
    try {
      emit(state.fetchingState());
      await _userSub?.cancel();
      _userSub = _gateway.fetchCurrentUser().listen((user) {
        emit(state.fetchedState(user: user));
      }, onError: (err) => emit(state.failedFetchState('$err')));
    } catch (err) {
      emit(state.failedCreateState('$err'));
    }
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _userSub?.cancel();
    return super.close();
  }
}
