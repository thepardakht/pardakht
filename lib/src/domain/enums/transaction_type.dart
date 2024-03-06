enum TransactionType {
  none,
  send,
  receive,
}

extension TransactionTypeParser on TransactionType {
  bool get isNone => this == TransactionType.none;
  bool get isSend => this == TransactionType.send;
  bool get isReceive => this == TransactionType.receive;

  static TransactionType fromName(String? name,
      [TransactionType value = TransactionType.none]) {
    if (name == null) return value;
    try {
      return TransactionType.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}
