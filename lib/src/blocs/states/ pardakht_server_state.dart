import 'package:oauth2/oauth2.dart' as oauth2;

enum AuthorizationStateStatus {
  idle,
  fetching,
  fetched,
  failedFetch,
}

extension AuthorizationStateStatusParser on AuthorizationStateStatus {
  bool get isIdle => this == AuthorizationStateStatus.idle;

  bool get isFetching => this == AuthorizationStateStatus.fetching;
  bool get isFetched => this == AuthorizationStateStatus.fetched;
  bool get isFailedFetch => this == AuthorizationStateStatus.failedFetch;

  static AuthorizationStateStatus fromName(String? name,
      [AuthorizationStateStatus value = AuthorizationStateStatus.idle]) {
    if (name == null) return value;
    try {
      return AuthorizationStateStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}

class PardakhtServerState {
  final oauth2.Client? client;
  final AuthorizationStateStatus status;
  final String? error;
  PardakhtServerState({
    required this.client,
    required this.error,
    required this.status,
  });

  PardakhtServerState.init({
    this.client,
    this.error,
    this.status = AuthorizationStateStatus.idle,
  });

  PardakhtServerState copyWith({
    AuthorizationStateStatus? status,
    String? error,
    oauth2.Client? client,
  }) {
    return PardakhtServerState(
      status: status ?? this.status,
      error: error ?? this.error,
      client: client ?? this.client,
    );
  }

  PardakhtServerState idleState() {
    return copyWith(
      status: AuthorizationStateStatus.idle,
    );
  }

  PardakhtServerState fetchingState() {
    return copyWith(
      status: AuthorizationStateStatus.fetching,
    );
  }

  PardakhtServerState fetchedState({oauth2.Client? client}) {
    return copyWith(
      status: AuthorizationStateStatus.fetched,
      client: client ?? this.client,
    );
  }

  PardakhtServerState failedFetchState(String? error) {
    return copyWith(
      status: AuthorizationStateStatus.failedFetch,
      error: error,
    );
  }
}
