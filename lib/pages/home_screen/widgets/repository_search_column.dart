import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/providers/github_repository_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

class RepositorySearchColumn extends ConsumerWidget {
  const RepositorySearchColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubReposCount = ref.watch(githubReposCountProvider);
    return githubReposCount.when(data: (int count) {
      if (count == 0) {
        return const SizedBox.shrink();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.whatWeHaveFound,
            style: AppStyles.header.copyWith(color: AppColors.accentPrimary),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final currentGithubRepoFromIndex = ref
                    .watch(paginatedGithubReposProvider(index ~/ 15))
                    .whenData((pageData) {
                  return pageData.listOfRepos[index % 15];
                });
                return ProviderScope(
                  overrides: [
                    currentGithubRepoProvider
                        .overrideWithValue(currentGithubRepoFromIndex)
                  ],
                  child: const RepositoryItem(),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 8,
              ),
              itemCount: count,
            ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      log('error: $error');
      log('error: $stackTrace');
      return const Icon(Icons.error);
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

class RepositoryItem extends ConsumerWidget {
  const RepositoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRepo = ref.watch(currentGithubRepoProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.layer,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: currentRepo.when(
        data: (data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  data.name,
                  style: AppStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SvgPicture.asset(AppIcons.starFilled)
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
