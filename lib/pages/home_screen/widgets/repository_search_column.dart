import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/resources/app_strings.dart';
import 'package:github_surfer/pages/home_screen/widgets/repository_item.dart';
import 'package:github_surfer/providers/github_repository_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Fetched from API list section
class RepositorySearchColumn extends ConsumerWidget {
  const RepositorySearchColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Checks for any input
    final ifEmpty = ref.watch(paginatedRequestProvider).searchValue.isEmpty;

    ///Counts repo items to be built
    final githubReposCount = ref.watch(githubReposCountProvider);
    return githubReposCount.when(data: (int count) {
      ///No input show nothing
      if (count == 0 && ifEmpty) {
        return const SizedBox.shrink();
      }

      ///Nothing was found
      if (count == 0 && !ifEmpty) {
        return Column(
          children: [
            Text(
              AppStrings.whatWeHaveFound,
              style: AppStyles.header.copyWith(color: AppColors.accentPrimary),
            ),
            const Spacer(),
            const Center(
              child: Text(
                AppStrings.nothingWasFoundMessage,
                style: AppStyles.bodyMessage,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        );
      }

      ///Got some data
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
                /// At this point the paginatedGithubReposProvider stores the values of the
                /// list items of at least the first page
                ///
                /// (index ~/ 15): Performing a truncating division of the list item index by the number of
                /// items per page gives us the value of the current page that we then access using the
                /// family modifier of the paginatedGithubReposProvider provider
                /// This way calling 16 ~/ 15 = 1 will fetch the second page,
                /// and 31 ~/ 15 = 2 will fetch the 3rd page, and so on.
                final currentGithubRepoFromIndex = ref
                    .watch(paginatedGithubReposProvider(index ~/ 15))
                    .whenData((pageData) {
                  return pageData.listOfRepos[index % 15];
                });
                return ProviderScope(
                  overrides: [
                    /// Override the Unimplemented provider
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
