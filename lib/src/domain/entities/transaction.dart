import 'package:pardakht/src/domain/enums/transaction_status.dart';
import 'package:pardakht/src/domain/enums/transaction_type.dart';

class Transaction {
  final String? id;
  final String? userId;
  final DateTime? transactionDate;
  final TransactionType? transactionType;
  final double? amount;
  final String? destinationAccountId;
  final String? destinationAccountUsername;
  final String? destinationAccountName;
  final String? destinationAccountProfileUrl;
  final String? description;
  final TransactionStatus? transactionStatus;

  const Transaction({
    required this.id,
    required this.userId,
    required this.transactionDate,
    required this.transactionType,
    required this.amount,
    required this.destinationAccountId,
    required this.destinationAccountUsername,
    required this.destinationAccountName,
    required this.destinationAccountProfileUrl,
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
    this.destinationAccountUsername,
    this.destinationAccountName,
    this.destinationAccountProfileUrl,
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
    String? destinationAccountUsername,
    String? destinationAccountName,
    String? destinationAccountProfileUrl,
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
      destinationAccountUsername:
          destinationAccountUsername ?? this.destinationAccountUsername,
      destinationAccountName:
          destinationAccountName ?? this.destinationAccountName,
      destinationAccountProfileUrl:
          destinationAccountProfileUrl ?? this.destinationAccountProfileUrl,
      description: description ?? this.description,
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }

  Map<String, dynamic> toMap() {
    var json = <String, dynamic>{
      'pid': id,
      'fid': userId,
      'transaction_date': transactionDate,
      'transaction_type': transactionType?.name,
      'amount': amount,
      'destination_account_id': destinationAccountId,
      'destination_account_username': destinationAccountUsername,
      'destination_account_name': destinationAccountName,
      'destination_account_profile_url': destinationAccountProfileUrl,
      'description': description,
      'status': transactionStatus?.name,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  factory Transaction.fromMap(Map<String, dynamic>? json) {
    if (json == null) return const Transaction.init();
    return Transaction.init(
      id: json['pid'],
      userId: json['fid'],
      transactionDate: DateTime.parse(json['transaction_date']),
      transactionType: TransactionTypeParser.fromName(json['transaction_type']),
      amount: json['amount'],
      destinationAccountId: json['destination_account_id'],
      destinationAccountUsername: json['destination_account_username'],
      destinationAccountName: json['destination_account_name'],
      destinationAccountProfileUrl: json['destination_account_profile_url'],
      description: json['description'],
      transactionStatus: TransactionStatusParser.fromName(json['status']),
    );
  }

  static List<Transaction> listFromMaps(List? list) {
    if (list == null || list.isEmpty) return const [];
    final a = list
        .map((e) => Transaction.fromMap(e))
        .toList()
        .map((e) => e.transactionStatus);
    print(a);
    return list.map((e) => Transaction.fromMap(e)).toList();
  }
}
