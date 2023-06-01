import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_surfer/resources/app_strings.dart';
import 'package:github_surfer/pages/favorites_page/widgets/favorites_list.dart';
import 'package:github_surfer/providers/favorites_provider.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Builds favorite repos section from data fetch status, when success,
///transfers data to [FavoritesList]

class FavoritesListOnLoad extends ConsumerWidget {
  const FavoritesListOnLoad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesFuture = ref.watch(favoritesGetFutureProvider);
    return favoritesFuture.when(
      data: (data) {
        if (data.isEmpty) {
          return const Column(
            children: [
              Spacer(),
              Center(
                child: Text(
                  AppStrings.noFavoritesMessage,
                  style: AppStyles.bodyMessage,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          );
        }
        return const FavoritesList();
      },
      error: (_, __) => const Icon(Icons.error),
      loading: () => const CircularProgressIndicator.adaptive(),
    );
  }
}
