import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/favorites.cubit.dart';
import 'package:spacex_app/ui/pages/home.page.dart';
import 'package:spacex_app/ui/pages/onboarding.page.dart';
import 'package:spacex_app/ui/cubit/onboarding.cubit.dart';
import 'package:spacex_app/ui/cubit/onboarding.state.dart';

void main() {
  runApp(const LaunchApp());
}

class LaunchApp extends StatelessWidget {
  const LaunchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
        BlocProvider<OnboardingCubit>(create: (_) => OnboardingCubit()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Une super appli sur spaceX',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return state is OnboardingSeenState ? const HomePage() : const OnboardingPage();
            },
          ),
        );
      }),
    );
  }
}
