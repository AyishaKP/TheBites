import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thebites/src/login/presentation/auth/auth_state.dart';
import '../di/injection.dart';
import '../../login/presentation/auth/auth_cubit.dart';
import 'route_names.dart';

class AuthGuard {
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = sl<AuthCubit>();
    final status = auth.state.status;

    final goingToLogin = state.matchedLocation == RouteNames.login;
    final goingToSplash = state.matchedLocation == RouteNames.splash;

    // While checking session -> stay on splash
    if (status == AuthStatus.unknown) {
      return goingToSplash ? null : RouteNames.splash;
    }

    // Not logged in -> force login (allow login & splash)
    if (status == AuthStatus.unauthenticated) {
      if (goingToLogin || goingToSplash) return null;
      return RouteNames.login;
    }

    // Logged in -> avoid login/splash
    if (status == AuthStatus.authenticated) {
      if (goingToLogin || goingToSplash) return RouteNames.home;
    }

    return null;
  }
}