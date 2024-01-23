import 'dart:convert';
import 'dart:io';

import 'package:pardakht/src/blocs/interfaces/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/user.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PardakhtGatewayCloud implements PardakhtGateway {
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
  Stream<User> authorize() async* {
    try {
      const authorizationEndPoint =
          "http://127.0.0.1:8080/oauth/v1/authorize?scopes='all'&client_id='aksldlkdnasdalkn'&redirect_url='kdalskdna'";
      const tokenEndPoint = "http://127.0.0.1:8080/oauth/v1/token";
      final client = http.Client();
      final authorizationRequest = http.Request(
        'GET',
        Uri.parse(authorizationEndPoint),
      );
      authorizationRequest.followRedirects = false;
      final authorizationResponse = await client.send(authorizationRequest);
      if (authorizationResponse.statusCode == HttpStatus.found) {
        await launchUrl(Uri.parse(authorizationEndPoint));
        return;
      }
      final authorizeBodyBytes =
          await http.ByteStream(authorizationResponse.stream).toBytes();
      final authorizeResponse = utf8.decode(authorizeBodyBytes);
      final body = jsonEncode({
        'redirect_url': 'String',
        'scopes': 'String',
        'client_id': 'String',
        'client_secret': 'String',
        'token': authorizeResponse,
      });
      final tokenRequest = http.Request(
        "POST",
        Uri.parse(tokenEndPoint),
      );
      tokenRequest.followRedirects = false;
      tokenRequest.body = body;
      tokenRequest.headers['Content-Type'] = 'application/json';
      final tokenBodyByte =
          await http.ByteStream(authorizationResponse.stream).bytesToString();
      Map<String, dynamic> tokenResponse = json.decode(tokenBodyByte);
      print(tokenResponse);
      yield User.fromMap(tokenResponse);
    } on HttpException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
