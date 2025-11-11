import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/lunches.cubit.dart';
import 'package:spacex_app/ui/cubit/lunches.state.dart';
import 'package:spacex_app/ui/cubit/display.cubit.dart';
import 'package:spacex_app/ui/cubit/display.state.dart';
import 'package:spacex_app/ui/widget/grid.widget.dart';
import 'package:spacex_app/ui/widget/list.widget.dart';

import '../../data/models/lunch.model.dart';

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
  final LunchesCubit lunchCubit = LunchesCubit();
  final DisplayCubit displayCubit = DisplayCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    super.initState();
  }

  void _loadData() => lunchCubit.getData();
  void _toggleDisplay() => displayCubit.toggleDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCubit, DisplayCubitState>(
      bloc: displayCubit,
      builder: (BuildContext context, DisplayCubitState displayCubit) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('SpaceX Launches'),
              actions: [
                IconButton(
                  onPressed: _toggleDisplay,
                  tooltip: 'Changer la disposition',
                  icon: Icon(displayCubit.isGridView ? Icons.view_list : Icons.grid_view),
                ),
              ],
            ),
            body: BlocBuilder<LunchesCubit, CubitState<List<Lunch>>>(
                bloc: lunchCubit,
                builder: (BuildContext context, CubitState<List<Lunch>> lunchListCubit) {
                  if (lunchListCubit is FailureState) {
                    return Center(
                      child: Text('Error : ${(lunchListCubit as FailureState).message}'),
                    );
                  } else if (lunchListCubit is SuccessState<List<Lunch>>) {
                    List<Lunch> lunches = lunchListCubit.data;
                    if (displayCubit is ListState) {
                      return ListWidget(lunches: lunches);
                    } else {
                      return GridWidget(lunches: lunches);
                    }
                  }
                  else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
        );
      },
    );
  }
}
