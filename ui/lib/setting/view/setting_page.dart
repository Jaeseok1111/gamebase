import 'package:flutter/material.dart';
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      menu: AppMenu.settings,
      child: Center(
        child: Text("Settings"),
      ),
    );
  }
}
