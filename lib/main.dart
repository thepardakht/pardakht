import 'package:device_preview/device_preview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:kooza_flutter/kooza_flutter.dart';
import 'package:pardakht/app_router.dart';
import 'package:pardakht/theme.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final localDb = await Kooza.getInstance("pardakht_local");

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) {
      return EasyLocalization(
        supportedLocales: const [
          Locale("en", "US"),
          Locale("fa", "AF"),
        ],
        path: 'assets/locale',
        fallbackLocale: const Locale("en", "US"),
        child: AppProviders(
          boxCollection: localDb,
        ),
      );
    },
  ));
}

class AppProviders extends StatelessWidget {
  final Kooza boxCollection;
  const AppProviders({super.key, required this.boxCollection});

  @override
  Widget build(BuildContext context) {
    return const PardakhtApp();
    // return MultiBlocProvider(
    //   providers: [],
    //   child: const PardakhtApp(),
    // );
  }
}

class PardakhtApp extends StatelessWidget {
  const PardakhtApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.build(
      initialLocation: '/',
      isSignedIn: false,
      routes: AppRoutes.routes,
      paths: AppRoutes.paths,
      loginPaths: AppRoutes.loginPaths,
      publicPaths: AppRoutes.publicPaths,
    );

    final theme = AppTheme(
      lighTheme: AppThemes.light(AppThemes.theme),
      darkTheme: AppThemes.dark(AppThemes.theme),
    );
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: theme.lighTheme,
      darkTheme: theme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
