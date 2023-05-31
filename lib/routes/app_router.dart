import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_surfer/pages/home_screen/home_screen.dart';
import 'package:github_surfer/pages/splash_screen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;
    log('⤴️ ${settings.name}');
    switch (settings.name) {
      case SplashScreen.routeName:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
        );
      case HomeScreen.routeName:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
        );

      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
