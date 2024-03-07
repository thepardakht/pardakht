import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/user.dart';
import 'repositories/pardakht_gateway.dart';
import 'states/users_state.dart';
import 'states/auth_state.dart';
import 'auth_bloc.dart';

class UsersBloc extends Cubit<UsersState> {
  StreamSubscription<AuthState>? _authSub;

  final PardakhtRepository _gateway;
  UsersBloc({
    required PardakhtRepository gateway,
    required AuthBloc authBloc,
  })  : _gateway = gateway,
        super(const UsersState.init()) {
    _authSub = authBloc.stream.listen((event) {
      emit(state.fetchedState(currentUser: event.user));
    }, onError: (err) => emit(state.failedFetchState('$err')));

    // fetchUsers();
  }

  void selectUser(User user) {
    var selected = List<User>.from(state.selected);
    if (selected.any((e) => e.id == user.id)) {
      selected.removeWhere((e) => e.id == user.id);
      emit(state.copyWith(selected: selected));
      return;
    }
    selected.add(user);
    emit(state.copyWith(selected: selected));
  }

  void selectAll(List<User> users) {
    var selected = List<User>.from(state.selected);
    if (selected.isNotEmpty) {
      selected.clear();
      emit(state.copyWith(selected: selected));
      return;
    }
    selected.addAll(users);
    emit(state.copyWith(selected: selected));
  }

  // StreamSubscription<List<User>>? _usersSub;
  // void fetchUsers() async {
  //   try {
  //     emit(state.fetchingState());
  //     _usersSub?.cancel();
  //     _usersSub = _gateway.fetchUsers(null).listen((users) {
  //       emit(state.fetchedState(users: users));
  //     }, onError: (err) => emit(state.failedFetchState('$err')));
  //   } catch (err) {
  //     emit(state.failedFetchState('$err'));
  //   }
  // }

  void searchUsers(String? query) async {
    if (query == null || query.isEmpty) return emit(state.idleState());

    emit(state.searchingState());
    _gateway
        .searchUsers(query)
        .then(
          (value) => emit(state.searchedState(value)),
        )
        .onError(
          (error, stackTrace) => emit(
            state.failedFetchState('$error'),
          ),
        );
  }

  // void deleteUser(String id) async {
  //   try {
  //     emit(state.deletingState());
  //     await _gateway.deleteUser(id);
  //     emit(state.deletedState());
  //   } catch (err) {
  //     emit(state.failedDeleteState('$err'));
  //   }
  // }

  // void deleteSelected() async {
  //   try {
  //     emit(state.deletingState());
  //     final ids = state.selected.map((e) => '${e.id}').toList()
  //       ..removeWhere((e) => e == 'null');
  //     await _gateway.deleteUsers(ids);
  //     emit(state.deletedState());
  //   } catch (err) {
  //     emit(state.failedDeleteState('$err'));
  //   }
  // }

  // void deleteAll() async {
  //   try {
  //     emit(state.deletingState());
  //     final ids = state.users.map((e) => '${e.id}').toList()
  //       ..removeWhere((e) => e == 'null');
  //     await _gateway.deleteUsers(ids);
  //     emit(state.deletedState());
  //   } catch (err) {
  //     emit(state.failedDeleteState('$err'));
  //   }
  // }

  // void backUpUsers() async {
  //   try {
  //     emit(state.backingUpState());
  //     await _gateway.backUpUsers(null);
  //     emit(state.backedUpState());
  //   } catch (err) {
  //     emit(state.failedBackupState('$err'));
  //   }
  // }

  // void restoreUsers() async {
  //   try {
  //     emit(state.restoringState());
  //     final restored = await _gateway.restoreUsers(null);
  //     emit(state.restoredState(restored));
  //   } catch (err) {
  //     emit(state.failedRestoreState('$err'));
  //   }
  // }

  // @override
  // Future<void> close() async {
  //   await _authSub?.cancel();
  //   await _usersSub?.cancel();
  //   await _searchSub?.cancel();
  //   return super.close();
  // }
}
