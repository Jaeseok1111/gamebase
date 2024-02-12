import 'package:beamer/beamer.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart' hide AppBar;

part 'appbar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.menu,
    required this.child,
  });

  final AppMenu menu;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppBar(menu: menu),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
