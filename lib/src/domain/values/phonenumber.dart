class PhoneNumber {
  final String? countryCode;
  final String? areaCode;
  final String? number;

  PhoneNumber({
    required this.countryCode,
    required this.areaCode,
    required this.number,
  });

  PhoneNumber.init({
    this.countryCode,
    this.areaCode,
    this.number,
  });

  PhoneNumber copyWith({
    String? countryCode,
    String? areaCode,
    String? number,
  }) {
    return PhoneNumber(
      countryCode: countryCode ?? this.countryCode,
      areaCode: areaCode ?? this.areaCode,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'country_code': countryCode,
      'area_code': areaCode,
      'number': number,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory PhoneNumber.fromMap(Map<String, dynamic>? json) {
    if (json == null) return PhoneNumber.init();
    return PhoneNumber(
      countryCode: json['country_code'],
      areaCode: json['area_code'],
      number: json['number'],
    );
  }
}

