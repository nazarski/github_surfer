import 'package:flutter/material.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/pages/home_screen/widgets/search_section.dart';
import 'package:github_surfer/pages/widgets/app_app_bar.dart';
import 'package:github_surfer/pages/widgets/app_bar_icon_button.dart';
import 'package:github_surfer/resources/app_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: AppStrings.githubReposList,
        actions: [
          AppBarIconButton(
            onTap: () {},
            iconAsset: AppIcons.starFilled,
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: SearchSection(),
      ),
    );
  }
}
