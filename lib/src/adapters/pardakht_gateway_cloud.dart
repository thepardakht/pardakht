import 'dart:convert';
import 'dart:io';

import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/user.dart';

import 'package:http/http.dart' as http;

class PardakhtGatewayCloud implements PardakhtRepository {
  final String url;
  PardakhtGatewayCloud(this.url);

  final _client = http.Client();

  @override
  Future<void> connectUser(User user) async {
    final fetchCurrentUserUrl = Uri.parse("$url/connect_wallet");
    try {
      final json = jsonEncode(user.toMap());
      await _client
          .post(
        fetchCurrentUserUrl,
        headers: {
          "Content-Type": "application/json",
        },
        body: json,
      )
          .then((value) {
        if (value.statusCode != 200) {
          throw 'Request Faild! Try again ${value.statusCode}';
        }
      });
    } on HttpException catch (e) {
      throw 'Request Faild! ${e.message}';
    } catch (e) {
      throw 'Faild Connecting User! $e';
    }
  }

  @override
  Future<void> createUser(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Stream<User> fetchCurrentUser() async* {
    final requestUrl = Uri.parse("$url/user/");
    try {
      final users = await _client.get(
        requestUrl,
        headers: {
          "Content-Type": "application/json",
        },
      );
      final json = jsonDecode(users.body);
      yield User.fromMap(json);
    } on HttpException catch (e) {
      throw 'Request Faild! ${e.message}';
    } catch (e) {
      throw 'Faild Fecthing Current User Data! $e';
    }
  }

  @override
  Future<void> sendEmailVerificationCode() async {
    final requestUrl = Uri.parse("$url/user/email_verification_code");
    try {
      await _client.post(requestUrl);
    } on HttpException catch (e) {
      throw 'Request Faild! ${e.message}';
    } catch (e) {
      throw 'Faild Sending Verification code! $e';
    }
  }

  @override
  Future<void> verifyEmailVerificationCode(String code) async {
    final requestUrl = Uri.parse("$url/user/verify_email?code=$code");
    try {
      await _client.post(requestUrl);
    } on HttpException catch (e) {
      throw 'Request Faild! ${e.message}';
    } catch (e) {
      throw 'Faild Verifying Email! $e';
    }
  }
}
