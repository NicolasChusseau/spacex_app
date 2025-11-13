import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacex_app/ui/cubit/onboarding.state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  static const _prefsKey = 'has_seen_onboarding';

  OnboardingCubit() : super(const OnboardingNotSeenState()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool(_prefsKey) ?? false;
    emit(seen ? const OnboardingSeenState() : const OnboardingNotSeenState());
  }

  Future<void> setSeen(bool seen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, seen);
    emit(seen ? const OnboardingSeenState() : const OnboardingNotSeenState());
  }
}
