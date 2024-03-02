import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pardakht/src/views/screens/screen_auth.dart';
import 'package:pardakht/src/views/screens/screen_home.dart';

abstract class AppRouter {
  const AppRouter._();

  static GoRouter build({
    required bool isSignedIn,
    List<GoRoute> routes = const [],
    String initialLocation = '/',
    String? Function(GoRouterState)? redirect,
    List<String> paths = const [],
    List<String> publicPaths = const [],
    List<String> loginPaths = const [],
  }) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: <GoRoute>[
        ...routes,
      ],
      redirect: (_, state) {
        bool isOnPath = _paths(paths).any((e) => e == state.matchedLocation);
        bool isOnPublicPath =
            _publicPaths(publicPaths).any((e) => e == state.matchedLocation);

        bool isOnLoginPath =
            _loginPaths(loginPaths).any((e) => e == state.matchedLocation);
        if (redirect != null) return redirect(state);
        if (isOnPublicPath) return null;
        if (!isSignedIn && isOnPublicPath) return null;
        if (isSignedIn && !isOnLoginPath) return '/';
        if (!isSignedIn && isOnLoginPath) return '/authentication';
        if (!isSignedIn && isOnPath) return null;

        return null;
      },
      errorBuilder: (context, r) => Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Not found'),
          ),
        ),
      ),
    );
  }

  static List<String> _paths(List<String> paths) {
    return [
      '/authentication',
      ...paths,
    ];
  }

  static List<String> _loginPaths(List<String> loginPaths) {
    return [
      ...loginPaths,
    ];
  }

  static List<String> _publicPaths(List<String> publicPaths) {
    return [
      ...publicPaths,
    ];
  }
}

abstract class AppRoutes {
  const AppRoutes._();

  static final List<GoRoute> routes = <GoRoute>[
    GoRoute(
      path: ScreenAuthentication.path,
      builder: (_, state) {
        final token = state.uri.queryParameters['token'];
        return ScreenAuthentication(token: token);
      },
    ),
    GoRoute(
      path: ScreenHome.path,
      builder: (_, __) => const ScreenHome(),
    ),
  ];

  static const List<String> paths = [
    ScreenAuthentication.path,
  ];

  static const List<String> loginPaths = [
    ScreenHome.path,
  ];

  static const List<String> publicPaths = [];
}
