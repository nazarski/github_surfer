import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/providers/search_history_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_styles.dart';

class SearchHistoryColumn extends ConsumerWidget {
  const SearchHistoryColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchHistory = ref.watch(searchHistoryProvider);
    return searchHistory.when(data: (data) {
      if (data.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.searchHistory,
              style: AppStyles.header.copyWith(
                color: AppColors.accentPrimary,
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                AppStrings.emptySearchHistoryMessage,
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.searchHistory,
            style: AppStyles.header.copyWith(
              color: AppColors.accentPrimary,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: AppColors.layer,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Text(
                        data[index].searchValue,
                        style: AppStyles.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 8,
              ),
              itemCount: data.length,
            ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return const Center(
        child: Icon(Icons.error),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}