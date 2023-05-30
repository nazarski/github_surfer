import 'package:flutter/material.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/pages/home_screen/home_screen.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accentPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.searchApp,
            style: AppStyles.header.copyWith(
              color: AppColors.layer,
            ),
          ),
          const SizedBox(height: 16,),
          const CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
