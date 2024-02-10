import 'package:flutter/material.dart';
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';

class CollectionViewPage extends StatelessWidget {
  const CollectionViewPage({super.key});

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
