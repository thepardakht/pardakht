enum TransactionStatus {
  none,
  pending,
  inprogress,
  completed,
  faild,
}

extension TransactionStatusParser on TransactionStatus {
  bool get isNone => this == TransactionStatus.none;
  bool get isPending => this == TransactionStatus.pending;
  bool get isInprogress => this == TransactionStatus.inprogress;
  bool get isCompleted => this == TransactionStatus.completed;
  bool get isFaild => this == TransactionStatus.faild;

  static TransactionStatus fromName(String? name,
      [TransactionStatus value = TransactionStatus.none]) {
    if (name == null) return value;
    try {
      return TransactionStatus.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}
