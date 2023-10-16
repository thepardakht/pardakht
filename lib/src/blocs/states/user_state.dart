import '../../domain/entities/user.dart';
import '../../domain/entities/user.dart';

enum UserStateStatus {
  idle,
  creating,
  created,
  failedCreate,
  fetching,
  fetched,
  failedFetch,
  modifying,
  modified,
  failedModify,
  deleting,
  deleted,
  failedDelete,
}

extension UserStateStatusParser on UserStateStatus {
  bool get isIdle => this == UserStateStatus.idle;
  bool get isCreating => this == UserStateStatus.creating;
  bool get isCreated => this == UserStateStatus.created;
  bool get isFailedCreate => this == UserStateStatus.failedCreate;
  bool get isFetching => this == UserStateStatus.fetching;
  bool get isFetched => this == UserStateStatus.fetched;
  bool get isFailedFetch => this == UserStateStatus.failedFetch;
  bool get isModfiying => this == UserStateStatus.modifying;
  bool get isModified => this == UserStateStatus.modified;
  bool get isFailedModify => this == UserStateStatus.failedModify;
  bool get isDeleting => this == UserStateStatus.deleting;
  bool get isDeleted => this == UserStateStatus.deleted;
  bool get isFailedDelete => this == UserStateStatus.failedDelete;

  static UserStateStatus fromName(String? name,
      [UserStateStatus value = UserStateStatus.idle]) {
    if (name == null) return value;
    try {
      return UserStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class UserState {
  final User currentUser;
  final UserStateStatus status;
  final String? error;
  final User user;

  const UserState({
    required this.currentUser,
    required this.status,
    required this.error,
    required this.user,
  });

  const UserState.init({
    this.currentUser = const User.init(),
    this.status = UserStateStatus.idle,
    this.error,
    this.user = const User.init(),
  });

  UserState copyWith({
    User? currentUser,
    UserStateStatus? status,
    String? error,
    User? user,
  }) {
    return UserState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  UserState idleState() {
    return copyWith(
      status: UserStateStatus.idle,
    );
  }

  UserState creatingState() {
    return copyWith(
      status: UserStateStatus.creating,
    );
  }

  UserState createdState() {
    return copyWith(
      status: UserStateStatus.created,
    );
  }

  UserState failedCreateState(String? error) {
    return copyWith(
      status: UserStateStatus.failedCreate,
      error: error,
    );
  }

  UserState fetchingState() {
    return copyWith(
      status: UserStateStatus.fetching,
    );
  }

  UserState fetchedState({User? user, User? currentUser}) {
    return copyWith(
      status: UserStateStatus.fetched,
      user: user,
      currentUser: currentUser,
    );
  }

  UserState failedFetchState(String? error) {
    return copyWith(
      status: UserStateStatus.failedFetch,
      error: error,
    );
  }

  UserState modifyingState() {
    return copyWith(
      status: UserStateStatus.modifying,
    );
  }

  UserState modifiedState(User? user) {
    return copyWith(
      status: UserStateStatus.modified,
      user: user,
    );
  }

  UserState failedModifyState(String? error) {
    return copyWith(
      status: UserStateStatus.failedModify,
      error: error,
    );
  }

  UserState deletingState() {
    return copyWith(
      status: UserStateStatus.deleting,
    );
  }

  UserState deletedState() {
    return copyWith(
      status: UserStateStatus.deleted,
    );
  }

  UserState failedDeleteState(String? error) {
    return copyWith(
      status: UserStateStatus.failedDelete,
      error: error,
    );
  }
}
