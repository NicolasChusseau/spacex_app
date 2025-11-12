import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/data/models/launch.model.dart';
import 'package:spacex_app/ui/cubit/launches.state.dart';

import '../../data/api/launch.service.dart';

class LaunchesCubit extends Cubit<CubitState<List<Launch>>> {
  LaunchesCubit() : super(InitialState());

  void getData() async {
    emit(LoadingState());

    try {
      final List<Launch> launches = await LaunchService.fetchLaunchList();
      emit(SuccessState(data: launches));
    } catch (e) {
      emit(FailureState(message: 'Failed to load launches'));
    }
  }
}