import 'package:pardakht/src/domain/entities/transaction.dart';

import '../../domain/entities/user.dart';

enum TransactionStateStatus {
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

extension TransactionStateStatusParser on TransactionStateStatus {
  bool get isIdle => this == TransactionStateStatus.idle;
  bool get isCreating => this == TransactionStateStatus.creating;
  bool get isCreated => this == TransactionStateStatus.created;
  bool get isFailedCreate => this == TransactionStateStatus.failedCreate;
  bool get isFetching => this == TransactionStateStatus.fetching;
  bool get isFetched => this == TransactionStateStatus.fetched;
  bool get isFailedFetch => this == TransactionStateStatus.failedFetch;
  bool get isModfiying => this == TransactionStateStatus.modifying;
  bool get isModified => this == TransactionStateStatus.modified;
  bool get isFailedModify => this == TransactionStateStatus.failedModify;
  bool get isDeleting => this == TransactionStateStatus.deleting;
  bool get isDeleted => this == TransactionStateStatus.deleted;
  bool get isFailedDelete => this == TransactionStateStatus.failedDelete;

  static TransactionStateStatus fromName(String? name,
      [TransactionStateStatus value = TransactionStateStatus.idle]) {
    if (name == null) return value;
    try {
      return TransactionStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class TransactionState {
  final TransactionStateStatus status;
  final String? error;
  final Transaction transaction;

  const TransactionState({
    required this.status,
    required this.error,
    required this.transaction,
  });

  const TransactionState.init({
    this.status = TransactionStateStatus.idle,
    this.error,
    this.transaction = const Transaction.init(),
  });

  TransactionState copyWith({
    User? currentUser,
    TransactionStateStatus? status,
    String? error,
    Transaction? transaction,
  }) {
    return TransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      transaction: transaction ?? this.transaction,
    );
  }

  TransactionState idleState() {
    return copyWith(
      status: TransactionStateStatus.idle,
    );
  }

  TransactionState creatingState() {
    return copyWith(
      status: TransactionStateStatus.creating,
    );
  }

  TransactionState createdState() {
    return copyWith(
      status: TransactionStateStatus.created,
    );
  }

  TransactionState failedCreateState(String? error) {
    return copyWith(
      status: TransactionStateStatus.failedCreate,
      error: error,
    );
  }

  TransactionState fetchingState() {
    return copyWith(
      status: TransactionStateStatus.fetching,
    );
  }

  TransactionState fetchedState({Transaction? transaction}) {
    return copyWith(
      status: TransactionStateStatus.fetched,
      transaction: transaction ?? this.transaction,
    );
  }

  TransactionState failedFetchState(String? error) {
    return copyWith(
      status: TransactionStateStatus.failedFetch,
      error: error,
    );
  }

  TransactionState modifyingState() {
    return copyWith(
      status: TransactionStateStatus.modifying,
    );
  }

  TransactionState modifiedState(Transaction? transaction) {
    return copyWith(
      status: TransactionStateStatus.modified,
      transaction: transaction ?? this.transaction,
    );
  }

  TransactionState failedModifyState(String? error) {
    return copyWith(
      status: TransactionStateStatus.failedModify,
      error: error,
    );
  }

  TransactionState deletingState() {
    return copyWith(
      status: TransactionStateStatus.deleting,
    );
  }

  TransactionState deletedState() {
    return copyWith(
      status: TransactionStateStatus.deleted,
    );
  }

  TransactionState failedDeleteState(String? error) {
    return copyWith(
      status: TransactionStateStatus.failedDelete,
      error: error,
    );
  }
}
