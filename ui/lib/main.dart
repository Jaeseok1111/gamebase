import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' hide AppBar;

import 'colors.dart';
import 'collection/view/collection_page.dart';
import 'log/view/log_page.dart';
import 'setting/view/setting_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
        useMaterial3: true,
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: BeamerDelegate(
        transitionDelegate: const NoAnimationTransitionDelegate(),
        locationBuilder: RoutesLocationBuilder(
          routes: {
            '/': (context, state, data) => const BeamPage(
                  title: "collections",
                  child: CollectionViewPage(),
                ),
            '/collections': (context, state, data) => const BeamPage(
                  title: "collections",
                  child: CollectionViewPage(),
                ),
            '/logs': (context, state, data) => const BeamPage(
                  title: "logs",
                  child: LogViewPage(),
                ),
            '/settings': (context, state, data) => const BeamPage(
                  title: "settings",
                  child: SettingsPage(),
                ),
          },
        ),
      ),
    );
  }
}
