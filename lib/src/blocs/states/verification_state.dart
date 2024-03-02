enum VerificationStateStatus {
  idle,
  isSending,
  isSend,
  failedSend,
  isVerifying,
  isVerified,
  faildVerify
}

extension VerificationStateStatusParser on VerificationStateStatus {
  bool get isIdle => this == VerificationStateStatus.idle;
  bool get isSending => this == VerificationStateStatus.isSending;

  bool get isSend => this == VerificationStateStatus.isSend;
  bool get isFailedSend => this == VerificationStateStatus.failedSend;
  bool get isVerifying => this == VerificationStateStatus.isVerifying;

  bool get isVerified => this == VerificationStateStatus.isVerified;
  bool get isFaildVerify => this == VerificationStateStatus.faildVerify;

  bool get isLoading {
    if (isSending) return true;
    if (isVerifying) return true;
    return false;
  }

  bool get isSuccess {
    if (isSend) return true;
    if (isVerified) return true;
    return false;
  }

  bool get isFailure {
    if (isFailedSend) return true;
    if (isFaildVerify) return true;
    return false;
  }

  static VerificationStateStatus fromName(
    String? name, [
    VerificationStateStatus value = VerificationStateStatus.idle,
  ]) {
    if (name == null) return value;
    try {
      return VerificationStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class VerificationState {
  final VerificationStateStatus status;
  final String? error;

  const VerificationState({
    required this.status,
    required this.error,
  });

  const VerificationState.init({
    this.status = VerificationStateStatus.idle,
    this.error,
  });

  VerificationState copyWith({
    VerificationStateStatus? status,
    String? error,
  }) {
    return VerificationState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  VerificationState idleState() {
    return copyWith(status: VerificationStateStatus.idle);
  }

  VerificationState loadingState(VerificationStateStatus status) {
    return copyWith(status: status);
  }

  VerificationState successState(VerificationStateStatus status) {
    return copyWith(
      status: status,
    );
  }

  VerificationState failureState(VerificationStateStatus status,
      {dynamic error}) {
    return copyWith(status: status, error: '$error');
  }
}
