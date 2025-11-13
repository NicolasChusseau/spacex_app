sealed class DisplayFavoritesCubitState {
  const DisplayFavoritesCubitState();

  bool get showFavoritesOnly => this is DisplayFavoritesState;
}

class DisplayFavoritesState extends DisplayFavoritesCubitState {
  const DisplayFavoritesState();
}

class NotDisplayFavoritesState extends DisplayFavoritesCubitState {
  const NotDisplayFavoritesState();
}
