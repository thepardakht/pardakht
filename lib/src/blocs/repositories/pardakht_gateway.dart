import '../../domain/entities/user.dart';

abstract class PardakhtRepository {
  Future<void> createUser(User user);
  Future<void> connectUser(User user);
  Future<void> sendEmailVerificationCode();
  Future<void> verifyEmailVerificationCode(String code);
  Stream<User> fetchCurrentUser();
}
