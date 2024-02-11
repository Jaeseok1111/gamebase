import 'package:flutter/material.dart' hide TextButton;
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gap/gap.dart';

import 'components/chart.dart';
import 'components/search.dart';
import 'components/toolbar.dart';

class LogViewPage extends StatefulWidget {
  const LogViewPage({super.key});

  @override
  State<LogViewPage> createState() => _LogViewPageState();
}

class _LogViewPageState extends State<LogViewPage> {
  var _chartKey = Object();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      menu: AppMenu.logs,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.base,
          vertical: Spacing.base - 5,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ToolBar(
                      onRefresh: () {
                        setState(() {
                          _chartKey = Object();
                        });
                      },
                    ),
                    const Gap(35),
                    const SearchField(),
                    const Gap(30),
                    LogsChart(
                      key: ValueKey(_chartKey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
