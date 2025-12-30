import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thebites/main.dart';
import 'auth_guard.dart';
import 'route_names.dart';
import '../../login/presentation/pages/splash_page.dart';
import '../../login/presentation/pages/login_page.dart';
//import '../../presentation/home/home_stub.dart';

class AppRouter {
  static GoRouter router({
    required AuthGuard guard,
    required Listenable refreshListenable,
  }) {
    return GoRouter(
      initialLocation: RouteNames.splash,
      refreshListenable: refreshListenable,
      redirect: guard.redirect,
      routes: [
        GoRoute(
          path: RouteNames.splash,
          builder: (_, __) => const SplashPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (_, __) => const LoginPage(),
        ),
        // GoRoute(
        //   path: RouteNames.home,
        //   builder: (_, __) => const MyHomePage(),
        // ),
      ],
    );
  }
}