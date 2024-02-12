import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:gamebase_ui/util/format.dart';

class LogsChart extends StatelessWidget {
  const LogsChart({super.key});

  @override
  Widget build(BuildContext context) {
    var spots = const [
      LineChartSpot(2024021100, 200),
      LineChartSpot(2024021101, 500),
      LineChartSpot(2024021102, 1200),
      LineChartSpot(2024021105, 200),
      LineChartSpot(2024021112, 400),
      LineChartSpot(2024021113, 1000),
      LineChartSpot(2024021114, 300),
    ];

    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return SizedBox(
          width: double.maxFinite,
          height: 200,
          child: Stack(
            children: [
              LineChart(
                spots: snapshot.connectionState == ConnectionState.waiting
                    ? []
                    : spots,
                style: _styleForm(),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(
                  child: RotateAnimation(
                    duration: Duration(milliseconds: 500),
                    child: FaIcon(
                      FontAwesomeIcons.circleNotch,
                      color: MyColors.primary,
                      size: 40,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  LineChartStyleForm _styleForm() {
    return LineChartStyleForm(
      min: const Size(0, 2024021100),
      borderColor: MyColors.baseAlt2Color,
      titles: LineChartTitles(
        left: LineChartTitleStyleForm(
          reservedSize: 30,
          interval: 500,
          text: (value) {
            if (value % 1 != 0) {
              return null;
            }

            if (value.toInt() % 500 != 0) {
              return null;
            }

            return value.toInt().toString();
          },
          textStyle: const TextStyle(
            color: MyColors.hintColor,
            fontSize: 10,
          ),
        ),
        bottom: LineChartTitleStyleForm(
          text: (value) {
            DateTime? time = Format.int2DateTime(value.toInt());
            if (time == null) {
              return null;
            }

            String text;

            if (time.hour == 0) {
              text = "${time.month}월 ${time.day}일";
            } else if (time.hour == 12) {
              text = "오후 12시";
            } else {
              return null;
            }

            return text;
          },
          textStyle: const TextStyle(
            color: MyColors.hintColor,
            fontSize: 11,
          ),
        ),
      ),
      bar: const LineChartBarStyleForm(color: MyColors.danger),
      touched: const LineChartTouchedSpotIndicatorStyleForm(
        shape: BoxShape.circle,
        radius: 8,
        lineColor: Colors.transparent,
        dotColor: MyColors.danger,
      ),
      tooltip: LineChartTooltipStyleForm(
        color: MyColors.primary,
        borderRadius: BorderCircular.base,
        fitInsideHorizontally: true,
        fitInsideVertically: false,
        label: (spot) {
          DateTime time = Format.int2DateTime(spot.x.toInt())!;

          return Text(
            "${time.year}년 ${time.month}월 ${time.day}일 ${time.hour}시",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          );
        },
        description: (spot) {
          return [
            const TextSpan(
              text: "Total requests: ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextSpan(
              text: spot.y.toInt().toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ];
        },
      ),
    );
  }
}
