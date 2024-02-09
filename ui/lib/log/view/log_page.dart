import 'package:flutter/material.dart';
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';

class LogViewPage extends StatelessWidget {
  const LogViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      menu: AppMenu.logs,
      child: Center(
        child: Text("Logs"),
      ),
    );
  }
}
