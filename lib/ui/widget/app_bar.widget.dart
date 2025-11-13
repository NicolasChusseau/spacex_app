import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/display_favorites.state.dart';
import 'package:spacex_app/ui/cubit/display.state.dart';
import 'package:spacex_app/ui/cubit/onboarding.cubit.dart';

class SpaceXAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SpaceXAppBarWidget({
    super.key,
    required this.onTitleTap,
    required this.onToggleDisplayFavorites,
    required this.favoritesDisplayState,
    required this.onToggleDisplay,
    required this.displayState,
  });

  final VoidCallback? onTitleTap;
  final VoidCallback onToggleDisplayFavorites;
  final DisplayFavoritesCubitState favoritesDisplayState;
  final VoidCallback onToggleDisplay;
  final DisplayCubitState displayState;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InkWell(
        onTap: onTitleTap,
        child: const Text('SpaceX Launches'),
      ),
      actions: [
        IconButton(
          onPressed: onToggleDisplayFavorites,
          icon: Icon(
            favoritesDisplayState is DisplayFavoritesState ? Icons.star : Icons.star_border,
          ),
          tooltip: favoritesDisplayState is DisplayFavoritesState
              ? 'Afficher tous les lancements'
              : 'Afficher les favoris uniquement',
        ),
        IconButton(
          onPressed: onToggleDisplay,
          tooltip: 'Changer la disposition',
          icon: Icon(displayState is GridState ? Icons.view_list : Icons.grid_view),
        ),
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'show_onboarding') {
              await context.read<OnboardingCubit>().setSeen(false);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'show_onboarding',
              child: Text("Afficher l'onboarding"),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

