import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/states/%20pardakht_server_state.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class PardakhtServerBloc extends Cubit<PardakhtServerState> {
  final String authorizationEndpoint;
  final String tokenEndpoint;
  final String clientId;
  final String clientSecret;
  final List<String>? scopes;
  final String redirectUrl;
  final File? credentialsFile;
  PardakhtServerBloc({
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    this.scopes,
    this.credentialsFile,
  }) : super(PardakhtServerState.init());

  Future<void> authorize() async {
    emit(state.fetchingState());
    final existCredentialsFile = await credentialsFile?.exists();
    try {
      if (credentialsFile != null && existCredentialsFile!) {
        final credentials = oauth2.Credentials.fromJson(
          await credentialsFile!.readAsString(),
        );
        final client = oauth2.Client(
          credentials,
          identifier: clientId,
          secret: clientSecret,
        );
        emit(state.fetchedState(client: client));
      }
      final grant = oauth2.AuthorizationCodeGrant(
        clientId,
        Uri.parse(authorizationEndpoint),
        Uri.parse(tokenEndpoint),
        secret: clientSecret,
      );
      final authorizationUrl =
          grant.getAuthorizationUrl(Uri.parse(redirectUrl));
      await redirect(authorizationUrl);
      final responseUrl = await listen(Uri.parse(redirectUrl));
      final client =
          await grant.handleAuthorizationResponse(responseUrl.queryParameters);
      emit(state.fetchedState(client: client));
    } catch (e) {
      emit(state.failedFetchState("error"));
    }
  }
}

Future<void> redirect(Uri url) async {
  // Client implementation detail
}

Future<Uri> listen(Uri url) async {
  // Client implementation detail
  return Uri();
}
