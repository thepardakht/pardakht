import 'package:pardakht/src/domain/entities/user.dart';

enum AuthStateStatus {
  idle,
  invalid,

  streaming,
  streamed,
  failedStream,

  authorizing,
  authorize,
  failedAuthorize,

  signingOut,
  signedOut,
  failedSignout,

  changingEmail,
  changedEmail,
  failedChangeEmail,

  changingPass,
  changedPass,
  failedChangePass,

  updating,
  updated,
  failedUpdate,

  deleting,
  deleted,
  failedDelete,

  resetingPass,
  resettedPass,
  confirmingPassReset,
  confirmedPassReset,
  failedPassReset,

  registeringUser,
  registeredUser,
  failedRegisterUser,
}

extension AuthStateStatusParser on AuthStateStatus {
  bool get isIdle => this == AuthStateStatus.idle;
  bool get isInvalid => this == AuthStateStatus.invalid;

  bool get isStreaming => this == AuthStateStatus.streaming;
  bool get isStreamed => this == AuthStateStatus.streamed;
  bool get isFailedStream => this == AuthStateStatus.failedStream;

  bool get isAuthorizing => this == AuthStateStatus.authorizing;
  bool get isAuthorize => this == AuthStateStatus.authorize;
  bool get isFailedAuthorize => this == AuthStateStatus.failedAuthorize;

  bool get isSigningOut => this == AuthStateStatus.signingOut;
  bool get isSignedOut => this == AuthStateStatus.signedOut;
  bool get isFailedSignout => this == AuthStateStatus.failedSignout;

  bool get isChangingEmail => this == AuthStateStatus.changingEmail;
  bool get isChangedEmail => this == AuthStateStatus.changedEmail;
  bool get isFailedChangeEmail => this == AuthStateStatus.failedChangeEmail;

  bool get isChangingPass => this == AuthStateStatus.changingPass;
  bool get isChangedPass => this == AuthStateStatus.changedPass;
  bool get isFailedChangePass => this == AuthStateStatus.failedChangePass;

  bool get isUpdating => this == AuthStateStatus.updating;
  bool get isUpdated => this == AuthStateStatus.updated;
  bool get isFailedUpdate => this == AuthStateStatus.failedUpdate;

  bool get isDeleting => this == AuthStateStatus.deleting;
  bool get isDeleted => this == AuthStateStatus.deleted;
  bool get isFailedDelete => this == AuthStateStatus.failedDelete;

  bool get isResetingPass => this == AuthStateStatus.resetingPass;
  bool get isResettedPass => this == AuthStateStatus.resettedPass;
  bool get isConfirmingPassReset => this == AuthStateStatus.confirmingPassReset;
  bool get isConfirmedPassReset => this == AuthStateStatus.confirmedPassReset;
  bool get isFailedPassReset => this == AuthStateStatus.failedPassReset;

  bool get isRegisteringUser => this == AuthStateStatus.registeringUser;
  bool get isRegisteredUser => this == AuthStateStatus.registeredUser;
  bool get isFailedRegisterUser => this == AuthStateStatus.failedRegisterUser;

  bool get isLoading {
    if (isStreaming) return true;

    if (isAuthorizing) return true;
    if (isSigningOut) return true;
    if (isChangingEmail) return true;
    if (isChangingPass) return true;
    if (isUpdating) return true;
    if (isDeleting) return true;
    if (isResetingPass) return true;
    if (isConfirmingPassReset) return true;
    if (isRegisteringUser) return true;
    return false;
  }

  bool get isLoadingGlobally {
    if (isStreaming) return true;

    if (isAuthorizing) return true;
    if (isSignedOut) return true;
    if (isDeleting) return true;
    if (isResetingPass) return true;
    if (isConfirmingPassReset) return true;
    return false;
  }

  bool get isSuccess {
    if (isStreamed) return true;

    if (isAuthorize) return true;
    if (isSignedOut) return true;
    if (isChangedEmail) return true;
    if (isChangedPass) return true;
    if (isUpdated) return true;
    if (isDeleted) return true;
    if (isResettedPass) return true;
    if (isConfirmedPassReset) return true;
    if (isRegisteredUser) return true;
    return false;
  }

  bool get isFailure {
    if (isFailedStream) return true;

    if (isFailedAuthorize) return true;
    if (isFailedSignout) return true;
    if (isFailedChangeEmail) return true;
    if (isFailedChangePass) return true;
    if (isFailedUpdate) return true;
    if (isFailedDelete) return true;
    if (isFailedPassReset) return true;
    if (isFailedRegisterUser) return true;
    if (isRegisteredUser) return true;
    return false;
  }

  static AuthStateStatus fromName(
    String? name, [
    AuthStateStatus value = AuthStateStatus.idle,
  ]) {
    if (name == null) return value;
    try {
      return AuthStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class AuthState {
  final AuthStateStatus status;
  final String? error;
  final bool? isAuthorized;
  final User user;

  const AuthState({
    required this.status,
    required this.error,
    required this.isAuthorized,
    required this.user,
  });

  const AuthState.init({
    this.status = AuthStateStatus.idle,
    this.error,
    this.isAuthorized,
    this.user = const User.init(),
  });

  AuthState copyWith({
    AuthStateStatus? status,
    String? error,
    bool? isAuthorized,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      isAuthorized: isAuthorized ?? isAuthorized,
      user: user ?? this.user,
    );
  }

  AuthState idleState() {
    return copyWith(status: AuthStateStatus.idle);
  }

  AuthState loadingState(AuthStateStatus status) {
    return copyWith(status: status);
  }

  AuthState successState(
    AuthStateStatus status, {
    bool? isAuthorized,
    User? user,
  }) {
    return copyWith(
      status: status,
      isAuthorized: isAuthorized ?? isAuthorized,
      user: user ?? this.user,
    );
  }

  AuthState failureState(AuthStateStatus status, {dynamic error}) {
    return copyWith(status: status, error: '$error');
  }
}
