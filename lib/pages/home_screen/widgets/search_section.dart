import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/pages/home_screen/widgets/repository_search_column.dart';
import 'package:github_surfer/pages/home_screen/widgets/search_history_column.dart';
import 'package:github_surfer/pages/widgets/search_text_field.dart';
import 'package:github_surfer/providers/search_section_provider.dart';

///Checks if any input is present and returns widget
///Input field is empty, returns [SearchHistoryColumn], if not [RepositorySearchColumn]
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
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: switch (searchSection) {
            SearchStatus.empty => const SearchHistoryColumn(),
            SearchStatus.value => const RepositorySearchColumn(),
          },
        ),
      ],
    );
  }
}
