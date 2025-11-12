import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorites.state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  static const _prefsKey = 'favorite_launch_ids';

  FavoritesCubit() : super(const FavoritesState()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(isLoading: true));
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_prefsKey) ?? [];
    emit(state.copyWith(
      favoriteIds: ids.toSet(),
      isLoading: false,
    ));
  }

  Future<void> toggleFavorite(BuildContext context, String launchId) async {
    final updatedIds = Set<String>.from(state.favoriteIds);
    if (updatedIds.contains(launchId)) {
      updatedIds.remove(launchId);
      displaySnackBar(context, 'Retiré des favoris');
    } else {
      updatedIds.add(launchId);
      displaySnackBar(context, 'Ajouté aux favoris');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, updatedIds.toList());
    emit(state.copyWith(favoriteIds: updatedIds));
  }

  bool isFavorite(String launchId) {
    return state.favoriteIds.contains(launchId);
  }

  void displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
