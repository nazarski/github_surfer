import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/models/github_repo_model.dart';
import 'package:github_surfer/providers/favorites_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteStarBuilder extends ConsumerWidget {
  const FavoriteStarBuilder(
      this.repo, {
        Key? key,
      }) : super(key: key);
  final GithubRepoModel repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesId = ref.watch(favoriteIdsProvider);
    final favoritesContainsId = favoritesId.contains(repo.repoId);
    return GestureDetector(
      onTap: () {
        final favoriteIdsProviderNotifier =
        ref.read(favoriteIdsProvider.notifier);
        if (favoritesContainsId) {
          favoriteIdsProviderNotifier.removeIdFromFavorites(repo);
        } else {
          favoriteIdsProviderNotifier.addIdToFavorites(repo);
        }
      },
      child: favoritesContainsId
          ? SvgPicture.asset(
        AppIcons.starFilled,
        colorFilter: const ColorFilter.mode(
          AppColors.accentPrimary,
          BlendMode.srcIn,
        ),
      )
          : SvgPicture.asset(AppIcons.starFilled),
    );
  }
}