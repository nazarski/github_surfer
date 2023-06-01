import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/models/githib_repo_model/github_repo_model.dart';
import 'package:github_surfer/providers/favorites_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';

/// Blue/grey star widget, depends on local favorite ids
class FavoriteStarBuilder extends ConsumerWidget {
  const FavoriteStarBuilder(
    this.repo, {
    Key? key,
  }) : super(key: key);
  final GithubRepoModel repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Gets favorite repos ids from local db
    final favoritesId = ref.watch(favoriteIdsProvider);

    ///Checks if set of favorite ids contains this single item [repoId]
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
