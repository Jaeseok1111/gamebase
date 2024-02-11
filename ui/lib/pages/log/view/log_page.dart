import 'package:flutter/material.dart' hide TextButton;
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gap/gap.dart';

import 'components/chart.dart';
import 'components/search.dart';
import 'components/table.dart';
import 'components/toolbar.dart';

class LogViewPage extends StatefulWidget {
  const LogViewPage({super.key});

  @override
  State<LogViewPage> createState() => _LogViewPageState();
}

class _LogViewPageState extends State<LogViewPage> {
  var _chartKey = Object();
  var _tableKey = Object();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      menu: AppMenu.logs,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacing.base - 5,
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spacing.base,
                            ),
                            child: ToolBar(
                              onRefresh: () {
                                setState(() {
                                  _chartKey = Object();
                                  _tableKey = Object();
                                });
                              },
                            ),
                          ),
                          const Gap(35),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.base - 5,
                            ),
                            child: SearchField(),
                          ),
                          const Gap(30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spacing.base,
                            ),
                            child: LogsChart(
                              key: ValueKey(_chartKey),
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      LogsTable(key: ValueKey(_tableKey)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
