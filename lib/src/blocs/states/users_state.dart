import '../../domain/entities/user.dart';

enum UsersStateStatus {
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
  searching,
  searched,
  failedSearch,
  backingUp,
  backedUp,
  failedBackup,
  restoring,
  restored,
  failedRestore,
}

extension UsersStateStatusParser on UsersStateStatus {
  bool get isIdle => this == UsersStateStatus.idle;
  bool get isCreating => this == UsersStateStatus.creating;
  bool get isCreated => this == UsersStateStatus.created;
  bool get isFailedCreate => this == UsersStateStatus.failedCreate;
  bool get isFetching => this == UsersStateStatus.fetching;
  bool get isFetched => this == UsersStateStatus.fetched;
  bool get isFailedFetch => this == UsersStateStatus.failedFetch;
  bool get isModfiying => this == UsersStateStatus.modifying;
  bool get isModified => this == UsersStateStatus.modified;
  bool get isFailedModify => this == UsersStateStatus.failedModify;
  bool get isDeleting => this == UsersStateStatus.deleting;
  bool get isDeleted => this == UsersStateStatus.deleted;
  bool get isFailedDelete => this == UsersStateStatus.failedDelete;
  bool get isSearching => this == UsersStateStatus.searching;
  bool get isSearched => this == UsersStateStatus.searched;
  bool get isFailedSearch => this == UsersStateStatus.failedSearch;
  bool get isBackingUp => this == UsersStateStatus.backingUp;
  bool get isBackedUp => this == UsersStateStatus.backedUp;
  bool get isFailedBackup => this == UsersStateStatus.failedBackup;
  bool get isRestoring => this == UsersStateStatus.restoring;
  bool get isRestored => this == UsersStateStatus.restored;
  bool get isFailedRestore => this == UsersStateStatus.failedRestore;

  static UsersStateStatus fromName(String? name,
      [UsersStateStatus value = UsersStateStatus.idle]) {
    if (name == null) return value;
    try {
      return UsersStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class UsersState {
  final User currentUser;
  final UsersStateStatus status;
  final String? error;
  final String query;
  final List<User> selected;
  final List<User> searchResult;
  final List<User> users;

  const UsersState({
    required this.currentUser,
    required this.status,
    required this.error,
    required this.query,
    required this.selected,
    required this.searchResult,
    required this.users,
  });

  const UsersState.init({
    this.currentUser = const User.init(),
    this.status = UsersStateStatus.idle,
    this.error,
    this.query = '',
    this.selected = const [],
    this.searchResult = const [],
    this.users = const [],
  });

  UsersState copyWith({
    User? currentUser,
    UsersStateStatus? status,
    String? error,
    String? query,
    List<User>? selected,
    List<User>? searchResult,
    List<User>? users,
  }) {
    return UsersState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
      error: error ?? this.error,
      query: query ?? this.query,
      selected: selected ?? this.selected,
      searchResult: searchResult ?? this.searchResult,
      users: users ?? this.users,
    );
  }

  UsersState idleState() {
    return copyWith(
      status: UsersStateStatus.idle,
    );
  }

  UsersState creatingState() {
    return copyWith(
      status: UsersStateStatus.creating,
    );
  }

  UsersState createdState() {
    return copyWith(
      status: UsersStateStatus.created,
    );
  }

  UsersState failedCreateState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedCreate,
      error: error,
    );
  }

  UsersState fetchingState() {
    return copyWith(
      status: UsersStateStatus.fetching,
    );
  }

  UsersState fetchedState({List<User>? users, User? currentUser}) {
    return copyWith(
      status: UsersStateStatus.fetched,
      users: users,
      currentUser: currentUser,
    );
  }

  UsersState failedFetchState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedFetch,
      error: error,
    );
  }

  UsersState modifyingState() {
    return copyWith(
      status: UsersStateStatus.modifying,
    );
  }

  UsersState modifiedState(List<User>? users) {
    return copyWith(
      status: UsersStateStatus.modified,
      users: users,
    );
  }

  UsersState failedModifyState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedModify,
      error: error,
    );
  }

  UsersState deletingState() {
    return copyWith(
      status: UsersStateStatus.deleting,
    );
  }

  UsersState deletedState() {
    return copyWith(
      status: UsersStateStatus.deleted,
    );
  }

  UsersState failedDeleteState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedDelete,
      error: error,
    );
  }

  UsersState searchingState() {
    return copyWith(
      status: UsersStateStatus.searching,
    );
  }

  UsersState searchedState(List<User>? searchResult) {
    return copyWith(
      status: UsersStateStatus.searched,
      searchResult: searchResult,
    );
  }

  UsersState failedSearchState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedSearch,
      error: error,
    );
  }

  UsersState selectedState(List<User>? selected) {
    return copyWith(
      selected: selected,
    );
  }

  UsersState backingUpState() {
    return copyWith(
      status: UsersStateStatus.backingUp,
    );
  }

  UsersState backedUpState() {
    return copyWith(
      status: UsersStateStatus.backedUp,
    );
  }

  UsersState failedBackupState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedBackup,
      error: error,
    );
  }

  UsersState restoringState() {
    return copyWith(
      status: UsersStateStatus.restoring,
    );
  }

  UsersState restoredState(List<User> users) {
    return copyWith(
      status: UsersStateStatus.restored,
      users: users,
    );
  }

  UsersState failedRestoreState(String? error) {
    return copyWith(
      status: UsersStateStatus.failedRestore,
      error: error,
    );
  }
}
