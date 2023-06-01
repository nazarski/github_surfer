import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/pages/home_screen/widgets/favorite_star_builder.dart';
import 'package:github_surfer/pages/home_screen/widgets/repo_item_wrap.dart';
import 'package:github_surfer/providers/github_repository_provider.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Single repo item fetched from API
class RepositoryItem extends ConsumerWidget {
  const RepositoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRepo = ref.watch(currentGithubRepoProvider);
    return RepoItemWrap(
      child: currentRepo.when(
        data: (repo) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  repo.name,
                  style: AppStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              FavoriteStarBuilder(repo)
            ],
          );
        },
        error: (error, stackTrace) {
          log('error: $error');
          log('error: $stackTrace');
          return const Center(
            child: Icon(Icons.error),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
