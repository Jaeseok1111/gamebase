import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' hide AppBar;

import 'pages/collection/view/collection_page.dart';
import 'pages/log/view/log_page.dart';
import 'pages/setting/view/settings_page.dart';
import 'styles.dart';

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
        locationBuilder: RoutesLocationBuilder(
          routes: {
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
