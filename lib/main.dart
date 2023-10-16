import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kooza_flutter/kooza_flutter.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';
import 'package:pardakht/src/blocs/states/auth_state.dart';
import 'package:pardakht/theme.dart';

import 'app_router.dart';
import 'pardakht.dart';
import 'src/adapters/pardakht_gateway_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await Kooza.getInstance("pardakht_local");
  final gateway = PardakhtGatewayLocal(prefs);

  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) {
          return EasyLocalization(
            supportedLocales: const [
              Locale("en", "US"),
              Locale("fa", "AF"),
            ],
            path: 'assets/locale',
            fallbackLocale: const Locale("en", "US"),
            child: PardakhtDataProvider(
              gateway: gateway,
              child: const AppGeneralSetup(),
            ),
          );
        }),
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
        return previous.isSignedIn != current.isSignedIn;
      },
      builder: (context, state) {
        final router = AppRouter.build(
          isSignedIn: state.isSignedIn,
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
