import 'package:pardakht/src/domain/entities/user.dart';

enum AuthStateStatus {
  idle,
  invalid,

  streaming,
  streamed,
  failedStream,

  connecting,
  connected,
  failedConnect,

  signingOut,
  signedOut,
  failedSignout,

  updating,
  updated,
  failedUpdate,

  deleting,
  deleted,
  failedDelete,

  creatingUser,
  createdUser,
  failCreateUser,

  creatingUserContact,
  createdUserContact,
  faildCreateUserContact,

  creatingUserLocation,
  createdUserLocation,
  faildCreateUserLocation,

  verifyingEmail,
  verifiedEmail,
  faildVerifyEmail,

  sendingEmailVerifactionCode,
  sendEmailVerificationCode,
  failSendEmailVerificationCode,
}

extension AuthStateStatusParser on AuthStateStatus {
  bool get isIdle => this == AuthStateStatus.idle;
  bool get isInvalid => this == AuthStateStatus.invalid;

  bool get isStreaming => this == AuthStateStatus.streaming;
  bool get isStreamed => this == AuthStateStatus.streamed;
  bool get isFailedStream => this == AuthStateStatus.failedStream;

  bool get isConnecting => this == AuthStateStatus.connecting;
  bool get isConnected => this == AuthStateStatus.connected;
  bool get isFailedConnect => this == AuthStateStatus.failedConnect;

  bool get isSigningOut => this == AuthStateStatus.signingOut;
  bool get isSignedOut => this == AuthStateStatus.signedOut;
  bool get isFailedSignout => this == AuthStateStatus.failedSignout;

  bool get isCreatingUser => this == AuthStateStatus.creatingUser;
  bool get isCreatedUser => this == AuthStateStatus.createdUser;
  bool get isFailedCreateUser => this == AuthStateStatus.failCreateUser;

  bool get isCreatedUserContact => this == AuthStateStatus.createdUserContact;
  bool get isCreatingUserContact => this == AuthStateStatus.creatingUserContact;
  bool get isFailedCreateUserContact =>
      this == AuthStateStatus.faildCreateUserContact;

  bool get isCreatedUserLocation => this == AuthStateStatus.createdUserLocation;
  bool get isCreatingUserLocation =>
      this == AuthStateStatus.creatingUserLocation;
  bool get isFailedCreateUserLocation =>
      this == AuthStateStatus.faildCreateUserLocation;

  bool get isUpdating => this == AuthStateStatus.updating;
  bool get isUpdated => this == AuthStateStatus.updated;
  bool get isFailedUpdate => this == AuthStateStatus.failedUpdate;

  bool get isDeleting => this == AuthStateStatus.deleting;
  bool get isDeleted => this == AuthStateStatus.deleted;
  bool get isFailedDelete => this == AuthStateStatus.failedDelete;

  bool get isVerifyingEmail => this == AuthStateStatus.verifyingEmail;
  bool get isVerifiedEmail => this == AuthStateStatus.verifiedEmail;
  bool get isFaildVerifyEmail => this == AuthStateStatus.faildVerifyEmail;

  bool get isSendingEmailVerifactionCode =>
      this == AuthStateStatus.sendingEmailVerifactionCode;
  bool get isSendEmailVerificationCode =>
      this == AuthStateStatus.sendEmailVerificationCode;
  bool get isFailSendEmailVerificationCode =>
      this == AuthStateStatus.failSendEmailVerificationCode;

  bool get isLoading {
    if (isStreaming) return true;
    if (isConnecting) return true;
    if (isCreatingUser) return true;
    if (isCreatingUserContact) return true;
    if (isCreatingUserLocation) return true;
    if (isSigningOut) return true;
    if (isUpdating) return true;
    if (isDeleting) return true;
    if (isVerifyingEmail) return true;
    if (isSendingEmailVerifactionCode) return true;

    return false;
  }

  bool get isSuccess {
    if (isStreamed) return true;
    if (isConnected) return true;
    if (isCreatedUser) return true;
    if (isCreatedUserContact) return true;
    if (isCreatedUserLocation) return true;
    if (isSignedOut) return true;
    if (isUpdated) return true;
    if (isDeleted) return true;
    if (isVerifiedEmail) return true;
    if (isSendEmailVerificationCode) return true;
    return false;
  }

  bool get isFailure {
    if (isFailedStream) return true;
    if (isFailedConnect) return true;
    if (isFailedCreateUser) return true;
    if (isFailedCreateUserLocation) return true;
    if (isFailedCreateUserContact) return true;
    if (isFailedSignout) return true;
    if (isFailedUpdate) return true;
    if (isFailedDelete) return true;
    if (isFaildVerifyEmail) return true;
    if (isFailSendEmailVerificationCode) return true;
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
  final bool? isConnected;
  final String? token;
  final User user;

  const AuthState({
    required this.status,
    required this.error,
    required this.isConnected,
    required this.user,
    required this.token,
  });

  const AuthState.init({
    this.status = AuthStateStatus.idle,
    this.error,
    this.isConnected,
    this.user = const User.init(),
    this.token,
  });

  AuthState copyWith({
    AuthStateStatus? status,
    String? error,
    bool? isConnected,
    User? user,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      isConnected: isConnected ?? this.isConnected,
      user: user ?? this.user,
      token: token ?? this.token,
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
    bool? isConnected,
    String? token,
    User? user,
  }) {
    return copyWith(
      status: status,
      isConnected: isConnected ?? this.isConnected,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  AuthState failureState(AuthStateStatus status, {dynamic error}) {
    return copyWith(status: status, error: '$error');
  }
}
