import 'package:pardakht/src/domain/values/phonenumber.dart';

import '../enums/user_role.dart';

//  "phone": {
//         "country_code": "",
//         "area_code": "93",
//         "number": "745682982"
//     },
//     "is_phone_verified": false,
//     "email": "s.alisinahussaini313@gmail.com",
//     "is_email_verified": true
class User {
  final String? id;
  final String? username;
  final String? name;
  final String? profilePictureUrl;
  final String? state;
  final String? city;
  final String? country;
  final String? address;
  final String? locationName;
  final String? postalCode;
  final PhoneNumber? phone;
  final String? email;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final String? password;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePictureUrl,
    required this.email,
    required this.password,
    required this.state,
    required this.city,
    required this.country,
    required this.address,
    required this.locationName,
    required this.postalCode,
    required this.phone,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  const User.init({
    this.id,
    this.username,
    this.name,
    this.profilePictureUrl,
    this.email,
    this.password,
    this.state,
    this.city,
    this.country,
    this.address,
    this.locationName,
    this.postalCode,
    this.phone,
    this.isEmailVerified,
    this.isPhoneVerified,
  });

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? profilePictureUrl,
    String? email,
    String? password,
    UserRole? role,
    String? state,
    String? city,
    String? country,
    String? address,
    String? locationName,
    String? postalCode,
    PhoneNumber? phone,
    bool? isEmailVerified,
    bool? isPhoneVerified,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      password: password ?? this.password,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      address: address ?? this.address,
      locationName: locationName ?? this.locationName,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'pid': id,
      'username': username,
      'name': name,
      'profile_picture_url': profilePictureUrl,
      'email': email,
      'password': password,
      'state': state,
      'city': city,
      'country': country,
      'address': address,
      'location_name': locationName,
      'postal_code': postalCode,
      'phone': phone?.toMap(),
      'is_phone_verified': isEmailVerified,
      'is_email_verified': isPhoneVerified,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory User.fromMap(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return const User.init();
    return User(
      id: id ?? json['pid'],
      username: json['username'],
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
      email: json['email'],
      password: json['password'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      address: json['address'],
      locationName: json['location_name'],
      postalCode: json['postal_code'],
      phone: PhoneNumber.fromMap(json['phone']),
      isEmailVerified: json['is_email_verified'],
      isPhoneVerified: json['is_phone_verified'],
    );
  }
  static List<User> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => User.fromMap(e)).toList();
  }
}
