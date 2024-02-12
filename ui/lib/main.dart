import 'package:beamer/beamer.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart' hide AppBar;

import 'beamer_locations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'gamebase.io',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MyColors.primary,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: BeamerDelegate(
        initialPath: "/collections",
        transitionDelegate: const NoAnimationTransitionDelegate(),
        locationBuilder: (routeInformation, _) =>
            BeamerLocations(routeInformation),
      ),
    );
  }
}
