class AuthorizationCode {
  final String? id;
  final String? businessId;
  final String? scopes;
  final String? clientId;
  final String? clientSecret;
  final DateTime? expiryDate;

  const AuthorizationCode({
    required this.id,
    required this.businessId,
    this.scopes,
    required this.clientId,
    required this.clientSecret,
    required this.expiryDate,
  });

  const AuthorizationCode.init({
    this.id,
    this.businessId,
    this.scopes = "all",
    this.clientId,
    this.clientSecret,
    this.expiryDate,
  });

  AuthorizationCode copyWith({
    String? id,
    String? businessId,
    String? scopes,
    String? clientId,
    String? clientSecret,
    DateTime? expiryDate,
  }) {
    return AuthorizationCode(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      clientId: clientId ?? this.clientId,
      scopes: scopes ?? this.scopes,
      clientSecret: clientSecret ?? this.clientSecret,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap(bool isFirestore) {
    var json = <String, dynamic>{
      'pid': id,
      'fid': businessId,
      'client_id': clientId,
      'client_secret': clientSecret,
      'scopes': scopes,
      'expiry_date': expiryDate
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory AuthorizationCode.fromMap(Map<String, dynamic>? json, [String? id]) {
    if (json == null) return const AuthorizationCode.init();
    return AuthorizationCode(
      id: id ?? json['pid'],
      businessId: json['fid'],
      scopes: json['scopes'],
      clientId: json['client_id'],
      clientSecret: json['client_secret'],
      expiryDate: json['expiry_date'],
    );
  }
  static List<AuthorizationCode> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => AuthorizationCode.fromMap(e)).toList();
  }
}
