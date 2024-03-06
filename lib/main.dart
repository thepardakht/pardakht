import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kooza_flutter/kooza_flutter.dart';

import 'package:pardakht/src/adapters/pardakht_gateway_cloud.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';

import 'package:pardakht/src/blocs/states/auth_state.dart';
import 'package:pardakht/theme.dart';

import 'app_router.dart';
import 'pardakht.dart';

void main() async {
  setPathUrlStrategy();
  final kooza = await Kooza.getInstance("Pardakht");
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  const storage = FlutterSecureStorage();
  final gateway = PardakhtGatewayCloud(
    prefs: kooza,
    url: "http://127.0.0.1:8080",
    localStorage: storage,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en", "US"),
        Locale("fa", "AF"),
      ],
      path: 'assets/locale',
      fallbackLocale: const Locale("en", "US"),
      child: PardakhtDataProvider(
        gateway: gateway,
        child: DevicePreview(
          builder: (context) {
            return const AppGeneralSetup();
          },
        ),
      ),
    ),
  );
}

class AppGeneralSetup extends StatelessWidget {
  const AppGeneralSetup({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(
      lighTheme: AppThemes.light(AppThemes.theme),
      darkTheme: AppThemes.dark(AppThemes.theme),
    );
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) {
        return previous.isConnected != current.isConnected;
      },
      builder: (context, state) {
        if (state.error != null) {
          print("ERROR: ${state.error}");
        }
        final router = AppRouter.build(
          isSignedIn: state.isConnected ?? false,
          routes: AppRoutes.routes,
          paths: AppRoutes.paths,
          publicPaths: AppRoutes.publicPaths,
          loginPaths: AppRoutes.loginPaths,
        );
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          builder: DevicePreview.appBuilder,
          theme: theme.lighTheme,
          darkTheme: theme.darkTheme,
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}
