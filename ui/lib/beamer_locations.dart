import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'pages/collection/view/collection_page.dart';
import 'pages/log/view/logs_view_page.dart';
import 'pages/login/login_page.dart';
import 'pages/setting/view/settings_page.dart';

class BeamerLocations extends BeamLocation<BeamState> {
  BeamerLocations(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    const title = "gamebase.io";

    return [
      if (state.uri.pathSegments.contains("login"))
        const BeamPage(
          key: ValueKey("login"),
          title: title,
          child: LoginPage(),
        ),
      if (state.uri.pathSegments.contains("collections"))
        const BeamPage(
          key: ValueKey("collections"),
          title: title,
          child: CollectionViewPage(),
        ),
      if (state.uri.pathSegments.contains("logs"))
        const BeamPage(
          key: ValueKey("logs"),
          title: title,
          child: LogsViewPage(),
        ),
      if (state.uri.pathSegments.contains("settings"))
        const BeamPage(
          key: ValueKey("settings"),
          title: title,
          child: SettingsPage(),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [
        "/login",
        "/collections",
        "/logs",
        "/settings",
      ];
}
