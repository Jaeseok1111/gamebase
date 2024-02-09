import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'colors.dart';

enum AppMenu { collections, logs, settings }

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
    required this.menu,
  });

  final AppMenu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: MyColors.baseAlt2Color),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _Logo(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _AppBarMenu(
                        icon: FontAwesomeIcons.database,
                        tooltip: "Collections",
                        route: "/collections",
                        selected: menu == AppMenu.collections,
                      ),
                      const Gap(20),
                      _AppBarMenu(
                        icon: FontAwesomeIcons.chartSimple,
                        tooltip: "Logs",
                        route: "/logs",
                        selected: menu == AppMenu.logs,
                      ),
                      const Gap(20),
                      _AppBarMenu(
                        icon: FontAwesomeIcons.screwdriverWrench,
                        tooltip: "Settings",
                        route: "/settings",
                        selected: menu == AppMenu.settings,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const _Avatar(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.beamToNamed("/");
        },
        child: SizedBox(
          width: 45,
          height: 45,
          child: Center(
            child: Image.asset(
              "assets/logo.png",
              width: 45,
              height: 45,
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarMenu extends StatefulWidget {
  const _AppBarMenu({
    required this.icon,
    required this.tooltip,
    required this.route,
    this.selected = false,
  });

  final IconData icon;
  final String tooltip;
  final String route;
  final bool selected;

  @override
  State<_AppBarMenu> createState() => _AppBarMenuState();
}

class _AppBarMenuState extends State<_AppBarMenu> {
  bool _onMouseHover = false;
  bool _onPanDown = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _onMouseHover = true;
      }),
      onExit: (event) => setState(() {
        _onMouseHover = false;
      }),
      child: GestureDetector(
        onTap: () {
          context.beamToNamed(widget.route);
        },
        onPanDown: (details) => setState(() {
          _onPanDown = true;
        }),
        onPanEnd: (details) => setState(() {
          _onPanDown = false;
        }),
        onPanCancel: () => setState(() {
          _onPanDown = false;
        }),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: 45,
          height: 45,
          decoration: ShapeDecoration(
            color: widget.selected
                ? Colors.white
                : _onPanDown
                    ? MyColors.baseAlt2Color
                    : _onMouseHover
                        ? MyColors.baseAlt1Color
                        : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                width: 2,
                color: widget.selected ? MyColors.primary : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: MyColors.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          debugPrint("avatar click");
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
          ),
          child: SvgPicture.asset(
            "assets/avatars/avatar0.svg",
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}
