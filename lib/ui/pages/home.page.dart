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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    super.initState();
  }

  void _loadData() => launchCubit.getData();
  void _toggleDisplay() => displayCubit.toggleDisplay();

  void _toggleDisplayFavorites() => displayFavoritesCubit.toggleDisplayFavorites();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCubit, DisplayCubitState>(
      bloc: displayCubit,
      builder: (BuildContext context, DisplayCubitState displayCubit) {
        return BlocBuilder<DisplayFavoritesCubit, DisplayFavoritesCubitState>(
          bloc: displayFavoritesCubit,
          builder: (BuildContext context, DisplayFavoritesCubitState displayFavoritesCubit) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('SpaceX Launches'),
                  actions: [
                    IconButton(
                        onPressed: _toggleDisplayFavorites,
                        icon: Icon(
                            displayFavoritesCubit.showFavoritesOnly
                                ? Icons.star
                                : Icons.star_border
                        )
                    ),
                    IconButton(
                      onPressed: _toggleDisplay,
                      tooltip: 'Changer la disposition',
                      icon: Icon(
                          displayCubit.isGridView ? Icons.view_list : Icons
                              .grid_view),
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
                              'Error : ${(launchListCubit as FailureState)
                                  .message}'),
                        );
                      } else
                      if (launchListCubit is SuccessState<List<Launch>>) {
                        List<Launch> launches = launchListCubit.data;
                        if (displayCubit is ListState) {
                          return ListWidget(launches: launches);
                        } else {
                          return GridWidget(launches: launches);
                        }
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
            );
          }
        );
      },
    );
  }
}
