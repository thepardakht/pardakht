class Wallet {
  final double? amount;

  const Wallet({
    required this.amount,
  });

  const Wallet.init({
    this.amount,
  });

  Wallet copyWith({
    double? amount,
  }) {
    return Wallet(
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'amount': amount,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory Wallet.fromMap(Map<String, dynamic>? json) {
    if (json == null) return const Wallet.init();
    return Wallet(
      amount: json['amount'],
    );
  }
  static List<Wallet> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => Wallet.fromMap(e)).toList();
  }
}
