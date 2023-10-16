import '../../domain/entities/user.dart';

abstract class PardakhtGateway {
  Future<void> createUser(User user);
  Stream<User> fetchUser(String userID);
  Stream<List<User>> fetchUsers(dynamic request);
  Future<void> modifyUser(User user);
  Future<void> modifyUsers(List<User> users);
  Future<void> deleteUser(String userID);
  Future<void> deleteUsers(List<String> usersIDs);
  Future<void> deleteAllUsers();
  Future<void> backUpUsers(dynamic request);
  Future<List<User>> restoreUsers(dynamic request);
}
