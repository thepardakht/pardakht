import 'package:pardakht/src/domain/entities/transaction.dart';
import 'package:pardakht/src/domain/entities/wallet.dart';

import '../../domain/entities/user.dart';

abstract class PardakhtRepository {
  Future<String> getToken();
  Future<void> createUser(User user);
  Future<String> connectUser(User user);
  Future<void> sendEmailVerificationCode(String userId);
  Future<String> verifyEmailVerificationCode(String userId, String code);
  Stream<User> fetchCurrentUser();
  Stream<Wallet> fetchCurrentUserWallet();
  Future<List<User>> searchUsers(String? value);
  Stream<List<Transaction>> fetchUserTransactions();
  Future<void> createTransaction(Transaction transaction);
  Future<void> modifyTransaction(Transaction transaction);
}
