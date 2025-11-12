import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/favorites.cubit.dart';
import 'package:spacex_app/ui/pages/home.page.dart';

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
          home: HomePage(),
        )
    );
  }
}

