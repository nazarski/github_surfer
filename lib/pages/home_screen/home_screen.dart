import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/pages/widgets/search_text_field.dart';
import 'package:github_surfer/providers/search_section_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.githubReposList),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: AppColors.accentPrimary),
                child: SvgPicture.asset(
                  AppIcons.starFilled,
                  colorFilter: const ColorFilter.mode(
                    AppColors.main,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(color: AppColors.layer),
          ),
        ),
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

class SearchSection extends ConsumerWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchSection = ref.watch(searchSectionProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextField(),
        switch (searchSection) {
          SearchStatus.empty => const SearchHistoryColumn(),
          SearchStatus.value => const RepositorySearchColumn(),
        },
      ],
    );
  }
}

class RepositorySearchColumn extends StatelessWidget {
  const RepositorySearchColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SearchHistoryColumn extends ConsumerWidget {
  const SearchHistoryColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          AppStrings.searchHistory,
          style: AppStyles.header.copyWith(
            color: AppColors.accentPrimary,
          ),
        ),

      ],
    );
  }
}
