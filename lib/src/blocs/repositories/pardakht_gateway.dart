import '../../domain/entities/user.dart';

abstract class PardakhtRepository {
  Future<String> getToken();
  Future<void> createUser(User user);
  Future<String> connectUser(User user);
  Future<void> sendEmailVerificationCode(String userId);
  Future<String> verifyEmailVerificationCode(String userId, String code);
  Stream<User> fetchCurrentUser();
}
