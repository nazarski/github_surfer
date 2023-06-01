import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/resources/app_strings.dart';
import 'package:github_surfer/pages/home_screen/home_screen.dart';
import 'package:github_surfer/providers/search_history_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Gets data from resent search values, when done, navigates to [HomeScreen]
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(searchHistoryProvider, (_, next) {
      if (next.hasValue) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }
    });
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
          const SizedBox(
            height: 16,
          ),
          const CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
