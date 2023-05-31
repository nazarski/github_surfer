import 'package:flutter/material.dart';
import 'package:github_surfer/resources/app_colors.dart';

class RepoItemWrap extends StatelessWidget {
  const RepoItemWrap({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.layer,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
