import '../enums/user_role.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  const User.init({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role = UserRole.admin,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    UserRole? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap(bool isFirestore) {
    var json = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role.name,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory User.fromMap(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return const User.init();
    return User(
      id: id ?? json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: UserRoleParser.fromName(json['role']),
    );
  }
  static List<User> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => User.fromMap(e)).toList();
  }
}
