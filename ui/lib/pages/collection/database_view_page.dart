import 'package:flutter/material.dart';
import 'package:gamebase_ui/pages/layout/layout.dart';

class DatabaseViewPage extends StatelessWidget {
  const DatabaseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      menu: AppMenu.collections,
      child: Center(
        child: Text("Collections"),
      ),
    );
  }
}
