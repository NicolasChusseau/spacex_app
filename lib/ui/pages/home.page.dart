import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/lunches.cubit.dart';
import 'package:spacex_app/ui/cubit/lunches.state.dart';

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
  final LunchesCubit cubit = LunchesCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    super.initState();
  }

  void _loadData() => cubit.getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SpaceX Launches'),
        ),
        body: BlocBuilder<LunchesCubit, CubitState<List<Lunch>>>(
        bloc: cubit,
        builder: (BuildContext context, CubitState<List<Lunch>> state) {
          if (state is FailureState) {
            return Center(
              child: Text('Error : ${(state as FailureState).message}'),
            );
          } else if (state is SuccessState<List<Lunch>>) {
            List<Lunch> lunches = state.data;
            return ListView.builder(
              itemCount: lunches.length,
              itemBuilder: (BuildContext context, int index) {
                final Lunch lunch = lunches[index];
                return ListTile(
                  title: Text(lunch.name),
                  subtitle: Text('Date: ${lunch.dateUtc}'),
                );
              },
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })
      );
  }
}
