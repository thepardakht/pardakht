import 'package:pardakht/src/domain/entities/wallet.dart';

import '../../domain/entities/user.dart';

enum WalletStateStatus {
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

extension WalletStateStatusParser on WalletStateStatus {
  bool get isIdle => this == WalletStateStatus.idle;
  bool get isCreating => this == WalletStateStatus.creating;
  bool get isCreated => this == WalletStateStatus.created;
  bool get isFailedCreate => this == WalletStateStatus.failedCreate;
  bool get isFetching => this == WalletStateStatus.fetching;
  bool get isFetched => this == WalletStateStatus.fetched;
  bool get isFailedFetch => this == WalletStateStatus.failedFetch;
  bool get isModfiying => this == WalletStateStatus.modifying;
  bool get isModified => this == WalletStateStatus.modified;
  bool get isFailedModify => this == WalletStateStatus.failedModify;
  bool get isDeleting => this == WalletStateStatus.deleting;
  bool get isDeleted => this == WalletStateStatus.deleted;
  bool get isFailedDelete => this == WalletStateStatus.failedDelete;

  static WalletStateStatus fromName(String? name,
      [WalletStateStatus value = WalletStateStatus.idle]) {
    if (name == null) return value;
    try {
      return WalletStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class WalletState {
  final WalletStateStatus status;
  final String? error;
  final Wallet wallet;

  const WalletState({
    required this.status,
    required this.error,
    required this.wallet,
  });

  const WalletState.init({
    this.status = WalletStateStatus.idle,
    this.error,
    this.wallet = const Wallet.init(),
  });

  WalletState copyWith({
    User? currentUser,
    WalletStateStatus? status,
    String? error,
    Wallet? wallet,
  }) {
    return WalletState(
      status: status ?? this.status,
      error: error ?? this.error,
      wallet: wallet ?? this.wallet,
    );
  }

  WalletState idleState() {
    return copyWith(
      status: WalletStateStatus.idle,
    );
  }

  WalletState creatingState() {
    return copyWith(
      status: WalletStateStatus.creating,
    );
  }

  WalletState createdState() {
    return copyWith(
      status: WalletStateStatus.created,
    );
  }

  WalletState failedCreateState(String? error) {
    return copyWith(
      status: WalletStateStatus.failedCreate,
      error: error,
    );
  }

  WalletState fetchingState() {
    return copyWith(
      status: WalletStateStatus.fetching,
    );
  }

  WalletState fetchedState({Wallet? wallet}) {
    return copyWith(
      status: WalletStateStatus.fetched,
      wallet: wallet ?? this.wallet,
    );
  }

  WalletState failedFetchState(String? error) {
    return copyWith(
      status: WalletStateStatus.failedFetch,
      error: error,
    );
  }

  WalletState modifyingState() {
    return copyWith(
      status: WalletStateStatus.modifying,
    );
  }

  WalletState modifiedState(Wallet? wallet) {
    return copyWith(
      status: WalletStateStatus.modified,
      wallet: wallet ?? this.wallet,
    );
  }

  WalletState failedModifyState(String? error) {
    return copyWith(
      status: WalletStateStatus.failedModify,
      error: error,
    );
  }

  WalletState deletingState() {
    return copyWith(
      status: WalletStateStatus.deleting,
    );
  }

  WalletState deletedState() {
    return copyWith(
      status: WalletStateStatus.deleted,
    );
  }

  WalletState failedDeleteState(String? error) {
    return copyWith(
      status: WalletStateStatus.failedDelete,
      error: error,
    );
  }
}
