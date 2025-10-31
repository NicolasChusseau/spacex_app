import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/data/models/lunch.model.dart';
import 'package:spacex_app/ui/cubit/lunches.state.dart';

import '../../data/api/lunch.service.dart';

class LunchesCubit extends Cubit<CubitState<List<Lunch>>> {
  LunchesCubit() : super(InitialState());

  void getData() async {
    emit(LoadingState());

    try {
      final List<Lunch> lunches = await LunchService.fetchLunchList();
      emit(SuccessState(data: lunches));
    } catch (e) {
      emit(FailureState(message: 'Failed to load lunches'));
    }
  }
}