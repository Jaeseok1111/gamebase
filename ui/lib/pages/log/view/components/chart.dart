import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gamebase_ui/util/format.dart';

class LogsChart extends StatefulWidget {
  const LogsChart({super.key});

  @override
  State<LogsChart> createState() => _LogsChartState();
}

class _LogsChartState extends State<LogsChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 200,
      child: LineChart(
        LineChartData(
          minY: 0,
          minX: 2024021100,
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: MyColors.baseAlt2Color),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 500,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  const FlLine(color: Colors.transparent),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 8,
                        color: MyColors.danger,
                      );
                    },
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: MyColors.primary,
              fitInsideHorizontally: true,
              tooltipRoundedRadius: BorderCircular.base,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  DateTime time = Format.int2DateTime(spot.x.toInt())!;

                  return LineTooltipItem(
                    "${time.year}년 ${time.month}월 ${time.day}일 ${time.hour}시",
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
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
                    ],
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: MyColors.danger,
              spots: const [
                FlSpot(2024021100, 200),
                FlSpot(2024021101, 500),
                FlSpot(2024021102, 1200),
                FlSpot(2024021105, 200),
                FlSpot(2024021112, 400),
                FlSpot(2024021113, 1000),
                FlSpot(2024021114, 300),
              ],
              barWidth: 1.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: MyColors.danger.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }

    if (value.toInt() % 500 != 0) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      fitInside: SideTitleFitInsideData.disable(),
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(
          color: MyColors.hintColor,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime? time = Format.int2DateTime(value.toInt());
    if (time == null) {
      return Container();
    }

    String text;

    if (time.hour == 0) {
      text = "${time.month}월 ${time.day}일";
    } else if (time.hour == 12) {
      text = "오후 12시";
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      fitInside: SideTitleFitInsideData.disable(),
      child: Text(
        text,
        style: const TextStyle(
          color: MyColors.hintColor,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
