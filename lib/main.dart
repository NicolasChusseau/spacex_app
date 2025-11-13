import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/favorites.cubit.dart';
import 'package:spacex_app/ui/pages/home.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacex_app/ui/pages/onboarding.page.dart';

void main() {
  runApp(const LaunchApp());
}

class LaunchApp extends StatelessWidget {
  const LaunchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => FavoritesCubit(),
        child: MaterialApp(
          title: 'Une super appli sur spaceX',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: FutureBuilder<bool>(
            future: SharedPreferences.getInstance().then((prefs) => prefs.getBool('has_seen_onboarding') ?? false),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              final seen = snapshot.data ?? false;
              return seen ? const HomePage() : const OnboardingPage();
            },
          ),
        )
    );
  }
}
