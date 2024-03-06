import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kooza_flutter/kooza_flutter.dart';

import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/user.dart';

import 'package:http/http.dart' as http;

class PardakhtGatewayCloud implements PardakhtRepository {
  final String url;
  final FlutterSecureStorage localStorage;
  final Kooza prefs;

  PardakhtGatewayCloud({
    required this.url,
    required this.localStorage,
    required this.prefs,
  });

  final client = http.Client();

  @override
  Future<String> getToken() async {
    // final token = await localStorage.read(key: "token");

    // if (token == null || token.isEmpty) {
    //   throw 'Token not Found!';
    // }
    // return token;

    // final doc = await prefs.singleDoc("auth").get();
    // final token = doc.data as String?;
    // if (token == null || token.isEmpty) {
    //   throw 'Token not Found!';
    // }
    // return token;

    return "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZWE5ZjhkOTQtYjIwZC00NGQwLTljMmQtZDI3YWIzZjdiYmMwIiwiZXhwIjoxNzExNTQxOTg1fQ.SqYjeO_9dMJTljmrV4RQmPu1-xq6NgekBmbAvN96aOc";
  }

  @override
  Future<String> connectUser(User user) async {
    final requestUrl = Uri.parse("$url/connect_wallet");
    try {
      final json = jsonEncode(user.toMap());
      final request = http.Request("POST", requestUrl);
      request.headers.addAll({
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      });
      request.persistentConnection = true;
      request.body = json;
      return await request.send().then((value) async {
        if (value.statusCode != 200) {
          throw 'Try again ${value.statusCode}';
        }
        final responseBody = await value.stream.bytesToString();
        return responseBody;
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
    final token = await getToken();
    final requestUrl = Uri.parse("$url/user/");
    if (token.isEmpty) {
      yield const User.init();
      return;
    }

    try {
      final request = await http.get(
        requestUrl,
        headers: {
          "Content-Type": "application/json",
          'Authorization': token,
        },
      );

      if (request.statusCode == 200) {
        final body = utf8.decode(request.bodyBytes);
        final json = jsonDecode(body);
        yield User.fromMap(json);
      } else {
        yield const User.init();
      }
    } catch (e) {
      throw 'Failed Fetching Current User Data! $e';
    }
  }

  @override
  Future<void> sendEmailVerificationCode(String userId) async {
    final requestUrl = Uri.parse("$url/user/email_verification_code");
    final json = jsonEncode({"user_id": userId});
    try {
      final request = http.Request("POST", requestUrl);
      request.headers.addAll({
        "Connection": "keep-alive",
        "Content-Type": "application/json",
      });
      request.body = json;
      await request.send().then((value) {
        if (value.statusCode != 200) {
          throw 'Try again ${value.statusCode}';
        }
      });
    } catch (e) {
      throw 'Faild Sending Verification code! $e';
    }
  }

  @override
  Future<String> verifyEmailVerificationCode(String userId, String code) async {
    final requestUrl = Uri.parse("$url/user/verify_email?code=$code");
    final json = jsonEncode({"user_id": userId});
    return await http.post(
      requestUrl,
      body: json,
      headers: {
        "Connection": "keep-alive",
        "Content-Type": "application/json",
      },
    ).then((value) {
      if (value.statusCode != 200) {
        throw 'Try again ${value.statusCode}';
      }
      final Map<String, dynamic> jsonResponse = jsonDecode(value.body);
      return jsonResponse["token"] ?? "";
    }).onError(
      (error, stackTrace) => throw 'Faild Verifying Email! $error',
    );
  }
}
