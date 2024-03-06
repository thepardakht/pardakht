import 'package:pardakht/src/domain/enums/transaction_status.dart';
import 'package:pardakht/src/domain/enums/transaction_type.dart';

class Transaction {
  final String? id;
  final String? userId;
  final DateTime? transactionDate;
  final TransactionType? transactionType;
  final double? amount;
  final String? destinationAccountId;
  final String? description;
  final TransactionStatus? transactionStatus;

  const Transaction({
    required this.id,
    required this.userId,
    required this.transactionDate,
    required this.transactionType,
    required this.amount,
    required this.destinationAccountId,
    required this.description,
    required this.transactionStatus,
  });

  const Transaction.init({
    this.id,
    this.userId,
    this.transactionDate,
    this.transactionType,
    this.amount,
    this.destinationAccountId,
    this.description,
    this.transactionStatus,
  });

  Transaction copyWith({
    String? id,
    String? userId,
    DateTime? transactionDate,
    TransactionType? transactionType,
    double? amount,
    String? destinationAccountId,
    String? description,
    TransactionStatus? transactionStatus,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      transactionDate: transactionDate ?? this.transactionDate,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      destinationAccountId: destinationAccountId ?? this.destinationAccountId,
      description: description ?? this.description,
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'pid': id,
      'fid': userId,
      'transaction_date': transactionDate,
      'transaction_type': transactionType,
      'amount': amount,
      'destination_account_id': destinationAccountId,
      'description': description,
      'status': transactionStatus,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory Transaction.fromMap(Map<String, dynamic>? json) {
    if (json == null) return const Transaction.init();
    return Transaction(
      id: json["pid"],
      userId: json["fid"],
      transactionDate: json["transaction_date"],
      transactionType: json["transaction_type"],
      amount: json["amount"],
      destinationAccountId: json["destination_account_id"],
      description: json["description"],
      transactionStatus: json["status"],
    );
  }
  static List<Transaction> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((e) => Transaction.fromMap(e)).toList();
  }
}
