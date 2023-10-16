import '../../domain/entities/user.dart';

class AuthState {
  final bool isSignedIn;
  final String? userID;
  final User? user;

  const AuthState({
    required this.isSignedIn,
    required this.userID,
    required this.user,
  });

  const AuthState.init({
    this.isSignedIn = false,
    this.userID,
    this.user,
  });

  AuthState copyWith({
    bool? isSignedIn,
    String? userID,
    User? user,
  }) {
    return AuthState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      userID: userID ?? this.userID,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap(bool isFirestore) {
    var json = <String, dynamic>{
      'isSignedIn': isSignedIn,
      'userID': userID,
      'user': user?.toMap(isFirestore),
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory AuthState.fromMap(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return const AuthState.init();
    return AuthState(
      isSignedIn: json['isSignedIn'],
      userID: json['userID'],
      user: User.fromMap(json['user']),
    );
  }
}
