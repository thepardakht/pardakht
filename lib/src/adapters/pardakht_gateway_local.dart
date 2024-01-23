import 'package:kooza_flutter/kooza_flutter.dart';

import '../domain/entities/user.dart';
import '../blocs/interfaces/pardakht_gateway.dart';

class PardakhtGatewayLocal implements PardakhtGateway {
  // static const String _usersRepo = 'users';

  final Kooza _prefs;
  PardakhtGatewayLocal(Kooza prefs) : _prefs = prefs;

  @override
  Future<void> backUpUsers(request) {
    // TODO: implement backUpUsers
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllUsers() {
    // TODO: implement deleteAllUsers
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String userID) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUsers(List<String> usersIDs) {
    // TODO: implement deleteUsers
    throw UnimplementedError();
  }

  @override
  Stream<User> fetchUser(String userID) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Stream<List<User>> fetchUsers(request) {
    // TODO: implement fetchUsers
    throw UnimplementedError();
  }

  @override
  Future<void> modifyUser(User user) {
    // TODO: implement modifyUser
    throw UnimplementedError();
  }

  @override
  Future<void> modifyUsers(List<User> users) {
    // TODO: implement modifyUsers
    throw UnimplementedError();
  }

  @override
  Future<List<User>> restoreUsers(request) {
    // TODO: implement restoreUsers
    throw UnimplementedError();
  }

  @override
  Stream<User> authorize() {
    // TODO: implement authorize
    throw UnimplementedError();
  }
}
