import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/pages/home_screen/widgets/repo_item_wrap.dart';
import 'package:github_surfer/providers/favorites_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Scrollable list of favorite repos
class FavoritesList extends ConsumerWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfRepos = ref.watch(favoritesListProvider);
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(listOfRepos[index].id),
          onDismissed: (_) {
            ref.read(favoritesListProvider.notifier).removeElement(
                  index: index,
                  repoId: listOfRepos[index].repoId,
                );
          },
          child: RepoItemWrap(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    listOfRepos[index].name,
                    style: AppStyles.body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.starFilled,
                  colorFilter: const ColorFilter.mode(
                    AppColors.accentPrimary,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: 8,
      ),
      itemCount: listOfRepos.length,
    );
  }
}
