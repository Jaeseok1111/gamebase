import 'package:flutter/material.dart' hide TextButton;
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gap/gap.dart';

import 'components/chart.dart';
import 'components/search.dart';
import 'components/toolbar.dart';

class LogViewPage extends StatelessWidget {
  const LogViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      menu: AppMenu.logs,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.base,
              vertical: Spacing.base - 5,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolBar(),
                Gap(35),
                SearchField(),
                Gap(30),
                LogsChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
