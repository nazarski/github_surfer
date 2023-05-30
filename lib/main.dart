import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_styles.dart';
import 'package:github_surfer/routes/app_router.dart';

void main() {
  runApp(const GithubSurferApp());
}

class GithubSurferApp extends StatelessWidget {
  const GithubSurferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Github Surfer',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.main,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.main,
            titleTextStyle: AppStyles.header,
            centerTitle: true,
            shadowColor: AppColors.layer,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: AppColors.layer,
            filled: true,
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentPrimary, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
