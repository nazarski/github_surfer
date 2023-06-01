import 'package:flutter/material.dart';
import 'package:github_surfer/resources/app_strings.dart';
import 'package:github_surfer/pages/favorites_page/widgets/favorites_list_onload.dart';
import 'package:github_surfer/pages/widgets/app_app_bar.dart';
import 'package:github_surfer/pages/widgets/app_bar_icon_button.dart';
import 'package:github_surfer/resources/app_icons.dart';

///Favorite repos page with named route [routeName]
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);
  static const routeName = 'favorites-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: AppStrings.favoriteReposList,
        leading: AppBarIconButton(
          onTap: () {
            Navigator.pop(context);
          },
          iconAsset: AppIcons.arrowLeft,
        ),
      ),
      body: const Column(
        children: [
          Expanded(
            child: FavoritesListOnLoad(),
          ),
        ],
      ),
    );
  }
}
