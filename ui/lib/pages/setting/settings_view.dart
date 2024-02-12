import 'package:flutter/material.dart';
import 'package:gamebase_ui/pages/layout/layout.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
