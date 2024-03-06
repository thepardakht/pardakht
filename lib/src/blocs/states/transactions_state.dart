import 'package:pardakht/src/domain/entities/transaction.dart';

import '../../domain/entities/user.dart';

enum TransactionsStateStatus {
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

extension TransactionsStateStatusParser on TransactionsStateStatus {
  bool get isIdle => this == TransactionsStateStatus.idle;
  bool get isCreating => this == TransactionsStateStatus.creating;
  bool get isCreated => this == TransactionsStateStatus.created;
  bool get isFailedCreate => this == TransactionsStateStatus.failedCreate;
  bool get isFetching => this == TransactionsStateStatus.fetching;
  bool get isFetched => this == TransactionsStateStatus.fetched;
  bool get isFailedFetch => this == TransactionsStateStatus.failedFetch;
  bool get isModfiying => this == TransactionsStateStatus.modifying;
  bool get isModified => this == TransactionsStateStatus.modified;
  bool get isFailedModify => this == TransactionsStateStatus.failedModify;
  bool get isDeleting => this == TransactionsStateStatus.deleting;
  bool get isDeleted => this == TransactionsStateStatus.deleted;
  bool get isFailedDelete => this == TransactionsStateStatus.failedDelete;
  bool get isSearching => this == TransactionsStateStatus.searching;
  bool get isSearched => this == TransactionsStateStatus.searched;
  bool get isFailedSearch => this == TransactionsStateStatus.failedSearch;
  bool get isBackingUp => this == TransactionsStateStatus.backingUp;
  bool get isBackedUp => this == TransactionsStateStatus.backedUp;
  bool get isFailedBackup => this == TransactionsStateStatus.failedBackup;
  bool get isRestoring => this == TransactionsStateStatus.restoring;
  bool get isRestored => this == TransactionsStateStatus.restored;
  bool get isFailedRestore => this == TransactionsStateStatus.failedRestore;

  static TransactionsStateStatus fromName(String? name,
      [TransactionsStateStatus value = TransactionsStateStatus.idle]) {
    if (name == null) return value;
    try {
      return TransactionsStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class TransactionsState {
  final User currentUser;
  final TransactionsStateStatus status;
  final String? error;
  final String query;
  final List<Transaction> selected;
  final List<Transaction> searchResult;
  final List<Transaction> transactions;

  const TransactionsState({
    required this.currentUser,
    required this.status,
    required this.error,
    required this.query,
    required this.selected,
    required this.searchResult,
    required this.transactions,
  });

  const TransactionsState.init({
    this.currentUser = const User.init(),
    this.status = TransactionsStateStatus.idle,
    this.error,
    this.query = '',
    this.selected = const [],
    this.searchResult = const [],
    this.transactions = const [],
  });

  TransactionsState copyWith({
    User? currentUser,
    TransactionsStateStatus? status,
    String? error,
    String? query,
    List<Transaction>? selected,
    List<Transaction>? searchResult,
    List<Transaction>? transactions,
  }) {
    return TransactionsState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
      error: error ?? this.error,
      query: query ?? this.query,
      selected: selected ?? this.selected,
      searchResult: searchResult ?? this.searchResult,
      transactions: transactions ?? this.transactions,
    );
  }

  TransactionsState idleState() {
    return copyWith(
      status: TransactionsStateStatus.idle,
    );
  }

  TransactionsState creatingState() {
    return copyWith(
      status: TransactionsStateStatus.creating,
    );
  }

  TransactionsState createdState() {
    return copyWith(
      status: TransactionsStateStatus.created,
    );
  }

  TransactionsState failedCreateState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedCreate,
      error: error,
    );
  }

  TransactionsState fetchingState() {
    return copyWith(
      status: TransactionsStateStatus.fetching,
    );
  }

  TransactionsState fetchedState({List<Transaction>? transactions}) {
    return copyWith(
      status: TransactionsStateStatus.fetched,
      transactions: transactions,
      currentUser: currentUser,
    );
  }

  TransactionsState failedFetchState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedFetch,
      error: error,
    );
  }

  TransactionsState modifyingState() {
    return copyWith(
      status: TransactionsStateStatus.modifying,
    );
  }

  TransactionsState modifiedState(List<Transaction>? transactions) {
    return copyWith(
      status: TransactionsStateStatus.modified,
      transactions: transactions,
    );
  }

  TransactionsState failedModifyState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedModify,
      error: error,
    );
  }

  TransactionsState deletingState() {
    return copyWith(
      status: TransactionsStateStatus.deleting,
    );
  }

  TransactionsState deletedState() {
    return copyWith(
      status: TransactionsStateStatus.deleted,
    );
  }

  TransactionsState failedDeleteState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedDelete,
      error: error,
    );
  }

  TransactionsState searchingState() {
    return copyWith(
      status: TransactionsStateStatus.searching,
    );
  }

  TransactionsState searchedState(List<Transaction>? searchResult) {
    return copyWith(
      status: TransactionsStateStatus.searched,
      searchResult: searchResult,
    );
  }

  TransactionsState failedSearchState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedSearch,
      error: error,
    );
  }

  TransactionsState selectedState(List<Transaction>? selected) {
    return copyWith(
      selected: selected,
    );
  }

  TransactionsState backingUpState() {
    return copyWith(
      status: TransactionsStateStatus.backingUp,
    );
  }

  TransactionsState backedUpState() {
    return copyWith(
      status: TransactionsStateStatus.backedUp,
    );
  }

  TransactionsState failedBackupState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedBackup,
      error: error,
    );
  }

  TransactionsState restoringState() {
    return copyWith(
      status: TransactionsStateStatus.restoring,
    );
  }

  TransactionsState restoredState(List<Transaction> transactions) {
    return copyWith(
      status: TransactionsStateStatus.restored,
      transactions: transactions,
    );
  }

  TransactionsState failedRestoreState(String? error) {
    return copyWith(
      status: TransactionsStateStatus.failedRestore,
      error: error,
    );
  }
}
