part of 'layout.dart';

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 35),
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                  );
                },
              ),
            ),
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
    return ElevatedButton(
      clipBehavior: Clip.antiAlias,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        elevation: 0.0,
        side: BorderSide.none,
        splashFactory: NoSplash.splashFactory,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderCircular.base),
        ),
      ),
      onPressed: () {
        context.beamToNamed("/collections");
      },
      child: const SizedBox(
        width: 45,
        height: 45,
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.scroll,
            color: MyColors.primary,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class _AppBarMenu extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        icon,
        color: MyColors.primary,
        size: 20,
      ),
      tooltip: tooltip,
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: const Size(45, 45),
        padding: EdgeInsets.zero,
        hoverColor: MyColors.baseAlt1Color,
        highlightColor: MyColors.baseAlt2Color,
        focusColor: MyColors.baseAlt2Color,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderCircular.lg),
          side: BorderSide(
            width: 2,
            color: selected ? MyColors.primary : Colors.transparent,
          ),
        ),
      ),
      onPressed: () {
        context.beamToNamed(route);
      },
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
