enum CardNetworkType {
  pardakhtCard,
  masterCard,
  visaCard,
}

extension CardNetworkTypeParser on CardNetworkType {
  bool get isMasterCard => this == CardNetworkType.masterCard;
  bool get isVisaCard => this == CardNetworkType.visaCard;
  bool get isPardakhtCard => this == CardNetworkType.pardakhtCard;
  static CardNetworkType fromName(String? name,
      [CardNetworkType value = CardNetworkType.pardakhtCard]) {
    if (name == null) return value;
    try {
      return CardNetworkType.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}
