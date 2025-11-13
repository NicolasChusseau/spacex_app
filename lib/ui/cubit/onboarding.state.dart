import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingSeenState extends OnboardingState {
  const OnboardingSeenState();
}

class OnboardingNotSeenState extends OnboardingState {
  const OnboardingNotSeenState();
}
