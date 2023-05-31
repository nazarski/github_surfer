import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/pages/home_screen/widgets/repo_item_wrap.dart';
import 'package:github_surfer/providers/github_repository_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

class RepositoryItem extends ConsumerWidget {
  const RepositoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRepo = ref.watch(currentGithubRepoProvider);
    return RepoItemWrap(
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
