import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_surfer/pages/favorites_page/favorites_page.dart';
import 'package:github_surfer/pages/home_screen/home_screen.dart';
import 'package:github_surfer/pages/splash_screen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
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
      case FavoritesPage.routeName:
        return PageTransition(
          child: const FavoritesPage(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
