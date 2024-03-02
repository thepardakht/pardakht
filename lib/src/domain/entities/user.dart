import '../enums/user_role.dart';

class User {
  final String? id;
  final String? username;
  final String? name;
  final String? email;
  final String? password;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
  });

  const User.init({
    this.id,
    this.username,
    this.name,
    this.email,
    this.password,
  });

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? password,
    UserRole? role,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory User.fromMap(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return const User.init();
    return User(
      id: id ?? json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
  static List<User> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => User.fromMap(e)).toList();
  }
}
