import 'package:design/design.dart';
import 'package:flutter/material.dart';

class LogsTable extends StatefulWidget {
  const LogsTable({super.key});

  @override
  State<LogsTable> createState() => _LogsTableState();
}

class _LogsTableState extends State<LogsTable> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        int items =
            snapshot.connectionState == ConnectionState.waiting ? 0 : numItems;

        return SizedBox(
          height: 50 * items + 100,
          child: _table(context, items),
        );
      },
    );
  }

  DataTable2 _table(BuildContext context, int numItems) {
    return DataTable2(
      isHorizontalScrollBarVisible: false,
      isVerticalScrollBarVisible: false,
      showCheckboxColumn: false,
      smRatio: 0.3,
      lmRatio: 3.5,
      headingRowDecoration: const BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(
            color: MyColors.baseAlt2Color,
            width: 2,
          ),
        ),
      ),
      border: TableBorder(
        borderRadius: BorderRadius.circular(BorderCircular.base),
        top: const BorderSide(color: MyColors.baseAlt2Color),
        horizontalInside: const BorderSide(color: MyColors.baseAlt2Color),
      ),
      headingRowColor: MaterialStateProperty.all(MyColors.body),
      dataRowColor: MaterialStateProperty.resolveWith((states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };

        if (states.any(interactiveStates.contains)) {
          return MyColors.baseAlt1Color;
        }

        return MyColors.body;
      }),
      columns: [
        DataColumn2(
          label: numItems == 0
              ? const RotateAnimation(
                  duration: Duration(milliseconds: 500),
                  child: FaIcon(
                    FontAwesomeIcons.circleNotch,
                    color: MyColors.primary,
                    size: 20,
                  ),
                )
              : Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
          size: ColumnSize.S,
        ),
        const DataColumn2(
          label: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.bookmark,
                color: MyColors.hintColor,
                size: 14,
              ),
              Gap(10),
              Text(
                "level",
                style: TextStyle(
                  color: MyColors.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          tooltip: "level",
          size: ColumnSize.M,
        ),
        const DataColumn2(
          label: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.fileCode,
                color: MyColors.hintColor,
                size: 14,
              ),
              Gap(10),
              Text(
                "message",
                style: TextStyle(
                  color: MyColors.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          tooltip: "message",
          size: ColumnSize.L,
        ),
        const DataColumn2(
          label: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.calendar,
                color: MyColors.hintColor,
                size: 14,
              ),
              Gap(10),
              Text(
                "created",
                style: TextStyle(
                  color: MyColors.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          tooltip: "created",
          size: ColumnSize.M,
        ),
      ],
      rows: List<DataRow2>.generate(
        numItems,
        (index) => DataRow2(
          cells: <DataCell>[
            DataCell(
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(maxWidth: 70),
                decoration: ShapeDecoration(
                  color: MyColors.baseAlt2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(BorderCircular.buttonHeight),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const ShapeDecoration(
                        color: MyColors.info,
                        shape: CircleBorder(),
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      "INFO",
                      style: TextStyle(
                        color: MyColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            DataCell(
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  "GET api/$index",
                  style: const TextStyle(
                    color: MyColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            DataCell(
              Text(
                DateTime.now().toUtc().toString(),
                style: const TextStyle(
                  color: MyColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
          onSelectChanged: (value) {},
        ),
      ),
    );
  }
}
