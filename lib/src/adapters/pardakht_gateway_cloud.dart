import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kooza_flutter/kooza_flutter.dart';

import 'package:pardakht/src/blocs/repositories/pardakht_gateway.dart';
import 'package:pardakht/src/domain/entities/transaction.dart';
import 'package:pardakht/src/domain/entities/user.dart';

import 'package:http/http.dart' as http;
import 'package:pardakht/src/domain/entities/wallet.dart';
import 'package:pardakht/src/domain/enums/transaction_status.dart';
import 'package:pardakht/src/domain/enums/transaction_type.dart';

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

    return "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiOTRkNzgyODEtZGRlYS00ZTVjLThmYjktYTNkMDdhYTRlNjkwIiwiZXhwIjoxNzExNjUyODk2fQ.L9E0T2WknbByqqBw4Vp-ANVwlX_vHDUSeWFDLRigkAQ";
    // return "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMDY4OWQ3MDItZTYwZS00N2IwLWJmN2UtOTMyOTg4ZGM0ZGFiIiwiZXhwIjoxNzExNjUyMzE2fQ.JaMcEiDFwpJY8iOkUktorfY340BoK9u6oRXcirI0c5g";
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

  @override
  Stream<Wallet> fetchCurrentUserWallet() async* {
    final token = await getToken();
    final requestUrl = Uri.parse("$url/user/wallet");
    if (token.isEmpty) {
      yield const Wallet.init();
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
        yield Wallet.fromMap(json);
      } else {
        yield const Wallet.init();
      }
    } catch (e) {
      throw 'Failed Fetching User Wallet Data! $e';
    }
  }

  @override
  Future<void> createTransaction(Transaction transaction) async {
    final requestUrl = Uri.parse("$url/user/transaction");
    final token = await getToken();
    final sendTransaction = transaction.copyWith(
        transactionType: TransactionType.send,
        transactionStatus: TransactionStatus.completed);
    final json = jsonEncode(sendTransaction.toMap());
    return await http.post(
      requestUrl,
      body: json,
      headers: {
        "Content-Type": "application/json",
        'Authorization': token,
      },
    ).then((value) {
      if (value.statusCode != 200) {
        throw 'Try again ${value.statusCode}';
      }
    }).onError(
      (error, stackTrace) => throw 'Faild Creating Transaction! $error',
    );
  }

  @override
  Stream<List<Transaction>> fetchUserTransactions() async* {
    final token = await getToken();
    final requestUrl = Uri.parse("$url/user/transactions");
    if (token.isEmpty) {
      yield [];
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
        yield Transaction.listFromMaps(json);
      } else {
        yield const [];
      }
    } catch (e) {
      throw 'Failed Fetching Transactions Data! $e';
    }
  }

  @override
  Future<void> modifyTransaction(Transaction transaction) async {
    final requestUrl = Uri.parse("$url/user/transaction");
    final json = jsonEncode(transaction.toMap());
    return await http.patch(
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
    }).onError(
      (error, stackTrace) => throw 'Faild Patching Transaction! $error',
    );
  }

  @override
  Future<List<User>> searchUsers(String? value) async {
    final token = await getToken();
    final requestUrl = Uri.parse("$url/user/search?value=$value");
    if (token.isEmpty) {
      throw 'no token Found';
    }
    try {
      final request = await http.get(
        requestUrl,
        headers: {'Authorization': token},
      );

      if (request.statusCode == 200) {
        final body = utf8.decode(request.bodyBytes);
        final json = jsonDecode(body);
        return User.listFromMaps(json);
      } else {
        return const [];
      }
    } catch (e) {
      throw 'Failed Searching users Data! $e';
    }
  }
}
