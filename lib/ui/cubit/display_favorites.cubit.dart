import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/display_favorites.state.dart';

class DisplayFavoritesCubit extends Cubit<DisplayFavoritesCubitState> {
  DisplayFavoritesCubit() : super(NotDisplayFavoritesState());

  void toggleDisplayFavorites() {
    if (state is DisplayFavoritesState) {
      emit(NotDisplayFavoritesState());
    } else {
      emit(DisplayFavoritesState());
    }
  }
}