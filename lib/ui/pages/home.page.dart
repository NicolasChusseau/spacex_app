import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/display_favorites.cubit.dart';
import 'package:spacex_app/ui/cubit/display_favorites.state.dart';
import 'package:spacex_app/ui/cubit/launches.cubit.dart';
import 'package:spacex_app/ui/cubit/launches.state.dart';
import 'package:spacex_app/ui/cubit/display.cubit.dart';
import 'package:spacex_app/ui/cubit/display.state.dart';
import 'package:spacex_app/ui/widget/grid.widget.dart';
import 'package:spacex_app/ui/widget/list.widget.dart';
import 'package:spacex_app/ui/cubit/favorites.cubit.dart';
import 'package:spacex_app/ui/cubit/favorites.state.dart';

import '../../data/models/launch.model.dart';

class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final LaunchesCubit launchCubit = LaunchesCubit();
  final DisplayCubit displayCubit = DisplayCubit();
  final DisplayFavoritesCubit displayFavoritesCubit = DisplayFavoritesCubit();
  final FavoritesCubit favoritesCubit = FavoritesCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    favoritesCubit.loadFavorites();
    super.initState();
  }

  void _loadData() => launchCubit.getData();
  void _toggleDisplay() => displayCubit.toggleDisplay();

  Future<void> _toggleDisplayFavorites() async {
    await favoritesCubit.loadFavorites();
    displayFavoritesCubit.toggleDisplayFavorites();
  }

  @override
  void dispose() {
    launchCubit.close();
    displayCubit.close();
    displayFavoritesCubit.close();
    favoritesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCubit, DisplayCubitState>(
      bloc: displayCubit,
      builder: (BuildContext context, DisplayCubitState displayState) {
        return BlocBuilder<DisplayFavoritesCubit, DisplayFavoritesCubitState>(
          bloc: displayFavoritesCubit,
          builder: (BuildContext context, DisplayFavoritesCubitState favoritesDisplayState) {
            return BlocBuilder<FavoritesCubit, FavoritesState>(
              bloc: favoritesCubit,
              builder: (BuildContext context, FavoritesState favoritesState) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('SpaceX Launches'),
                      actions: [
                        IconButton(
                            onPressed: _toggleDisplayFavorites,
                            icon: Icon(
                                favoritesDisplayState is DisplayFavoritesState
                                    ? Icons.star
                                    : Icons.star_border
                            )
                        ),
                        IconButton(
                          onPressed: _toggleDisplay,
                          tooltip: 'Changer la disposition',
                          icon: Icon(
                              displayState is GridState ? Icons.view_list : Icons.grid_view),
                        ),
                      ],
                    ),
                    body: BlocBuilder<LaunchesCubit, CubitState<List<Launch>>>(
                        bloc: launchCubit,
                        builder: (BuildContext context,
                            CubitState<List<Launch>> launchListCubit) {
                          if (launchListCubit is FailureState) {
                            return Center(
                              child: Text(
                                  'Error : ${(launchListCubit as FailureState).message}'),
                            );
                          } else if (launchListCubit is SuccessState<List<Launch>>) {
                            List<Launch> launches = launchListCubit.data;

                            List<Launch> displayedLaunches = launches;
                            if (favoritesDisplayState is DisplayFavoritesState) {
                              displayedLaunches = launches
                                  .where((l) => favoritesCubit.isFavorite(l.id))
                                  .toList();
                            }

                            if (displayState is ListState) {
                              return BlocProvider.value(
                                value: favoritesCubit,
                                child: ListWidget(launches: displayedLaunches),
                              );
                            } else {
                              return BlocProvider.value(
                                value: favoritesCubit,
                                child: GridWidget(launches: displayedLaunches),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })
                );
              },
            );
          }
        );
      },
    );
  }
}
