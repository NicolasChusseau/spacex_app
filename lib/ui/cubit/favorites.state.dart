import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteIds;
  final bool isLoading;

  const FavoritesState({
    this.favoriteIds = const {},
    this.isLoading = false,
  });

  FavoritesState copyWith({
    Set<String>? favoriteIds,
    bool? isLoading,
  }) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [favoriteIds, isLoading];
}
