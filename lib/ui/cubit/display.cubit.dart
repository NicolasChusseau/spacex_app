import 'package:flutter_bloc/flutter_bloc.dart';
import 'display.state.dart';

class DisplayCubit extends Cubit<DisplayCubitState> {
  DisplayCubit() : super(ListState());

  void toggleDisplay() {
    if (state is ListState) {
      emit(GridState());
    } else {
      emit(ListState());
    }
  }
}