import 'package:design/styles/styles.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/material.dart';

class LineChartTitleStyleForm {
  const LineChartTitleStyleForm({
    this.interval = 1,
    this.reservedSize = 22,
    required this.text,
    required this.textStyle,
    this.textAlign = TextAlign.center,
  });

  final double interval;
  final double reservedSize;

  final String? Function(double value) text;
  final TextStyle textStyle;
  final TextAlign textAlign;
}

class LineChartTitles {
  const LineChartTitles({
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  final LineChartTitleStyleForm? left;
  final LineChartTitleStyleForm? right;
  final LineChartTitleStyleForm? top;
  final LineChartTitleStyleForm? bottom;
}

class LineChartTouchedSpotIndicatorStyleForm {
  const LineChartTouchedSpotIndicatorStyleForm({
    required this.shape,
    required this.radius,
    required this.lineColor,
    required this.dotColor,
  });

  final BoxShape shape;
  final double radius;
  final Color lineColor;
  final Color dotColor;
}

class LineChartTooltipStyleForm {
  const LineChartTooltipStyleForm({
    required this.color,
    required this.fitInsideHorizontally,
    required this.fitInsideVertically,
    this.borderRadius = BorderCircular.base,
    required this.label,
    required this.description,
  });

  final Color color;
  final bool fitInsideHorizontally;
  final bool fitInsideVertically;
  final double borderRadius;

  final Text Function(fl.LineBarSpot spot) label;
  final List<TextSpan> Function(fl.LineBarSpot spot) description;
}

class LineChartBarStyleForm {
  const LineChartBarStyleForm({
    required this.color,
    this.width = 1.5,
    this.isStrokeCapRound = true,
    this.belowBarColor,
  });

  final Color color;
  final double width;
  final bool isStrokeCapRound;
  final Color? belowBarColor;
}

class LineChartStyleForm {
  const LineChartStyleForm({
    this.min,
    this.max,
    this.borderColor = MyColors.baseAlt2Color,
    this.titles,
    required this.bar,
    this.touched,
    this.tooltip,
  });

  final Size? min;
  final Size? max;

  final Color? borderColor;

  final LineChartTitles? titles;
  final LineChartBarStyleForm bar;
  final LineChartTouchedSpotIndicatorStyleForm? touched;
  final LineChartTooltipStyleForm? tooltip;
}

class LineChartSpot {
  const LineChartSpot(this.x, this.y);

  final double x;
  final double y;
}

class LineChart extends StatelessWidget {
  const LineChart({
    super.key,
    required this.spots,
    required this.style,
  });

  final List<LineChartSpot> spots;
  final LineChartStyleForm style;

  @override
  Widget build(BuildContext context) {
    return fl.LineChart(
      duration: Duration.zero,
      spots.isEmpty ? fl.LineChartData() : _loadData(spots),
    );
  }

  fl.LineChartData _loadData(List<LineChartSpot> spots) {
    return fl.LineChartData(
      minX: style.min?.width,
      minY: style.min?.height,
      maxX: style.max?.width,
      maxY: style.max?.height,
      borderData: style.borderColor != null
          ? fl.FlBorderData(
              show: true,
              border: Border.all(color: style.borderColor!),
            )
          : null,
      titlesData: style.titles != null
          ? _LineChartTitle(titles: style.titles!).build()
          : const fl.FlTitlesData(),
      lineTouchData: fl.LineTouchData(
        getTouchedSpotIndicator: style.touched != null
            ? (barData, spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return fl.TouchedSpotIndicatorData(
                    fl.FlLine(color: style.touched!.lineColor),
                    fl.FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        switch (style.touched!.shape) {
                          case BoxShape.rectangle:
                            return fl.FlDotSquarePainter(
                              color: style.touched!.dotColor,
                            );
                          case BoxShape.circle:
                            return fl.FlDotCirclePainter(
                              radius: style.touched!.radius,
                              color: style.touched!.dotColor,
                            );
                        }
                      },
                    ),
                  );
                }).toList();
              }
            : fl.defaultTouchedIndicators,
        touchTooltipData: style.tooltip != null
            ? fl.LineTouchTooltipData(
                tooltipBgColor: style.tooltip!.color,
                fitInsideHorizontally: style.tooltip!.fitInsideHorizontally,
                fitInsideVertically: style.tooltip!.fitInsideVertically,
                tooltipRoundedRadius: style.tooltip!.borderRadius,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    Text label = style.tooltip!.label(spot);

                    return fl.LineTooltipItem(
                      label.data!,
                      label.style!,
                      children: style.tooltip!.description(spot),
                    );
                  }).toList();
                },
              )
            : const fl.LineTouchTooltipData(),
      ),
      lineBarsData: [
        fl.LineChartBarData(
          color: style.bar.color,
          spots: spots.map((spot) => fl.FlSpot(spot.x, spot.y)).toList(),
          barWidth: style.bar.width,
          isStrokeCapRound: style.bar.isStrokeCapRound,
          dotData: const fl.FlDotData(show: false),
          belowBarData: fl.BarAreaData(
            show: true,
            color: style.bar.color.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}

class _LineChartTitle {
  const _LineChartTitle({required this.titles});

  final LineChartTitles titles;

  fl.FlTitlesData build() {
    return fl.FlTitlesData(
      show: true,
      topTitles: fl.AxisTitles(
        sideTitles: fl.SideTitles(
          showTitles: titles.top != null,
          interval: titles.top?.interval,
          reservedSize: titles.top?.reservedSize ?? 22,
          getTitlesWidget: (value, meta) =>
              _toWidget(style: titles.top, value: value, meta: meta),
        ),
      ),
      bottomTitles: fl.AxisTitles(
        sideTitles: fl.SideTitles(
          showTitles: titles.bottom != null,
          interval: titles.bottom?.interval,
          reservedSize: titles.bottom?.reservedSize ?? 22,
          getTitlesWidget: (value, meta) =>
              _toWidget(style: titles.bottom, value: value, meta: meta),
        ),
      ),
      leftTitles: fl.AxisTitles(
        sideTitles: fl.SideTitles(
          showTitles: titles.left != null,
          interval: titles.left?.interval,
          reservedSize: titles.left?.reservedSize ?? 22,
          getTitlesWidget: (value, meta) =>
              _toWidget(style: titles.left, value: value, meta: meta),
        ),
      ),
      rightTitles: fl.AxisTitles(
        sideTitles: fl.SideTitles(
          showTitles: titles.right != null,
          interval: titles.right?.interval,
          reservedSize: titles.right?.reservedSize ?? 22,
          getTitlesWidget: (value, meta) =>
              _toWidget(style: titles.right, value: value, meta: meta),
        ),
      ),
    );
  }

  Widget _toWidget({
    required LineChartTitleStyleForm? style,
    required double value,
    required fl.TitleMeta meta,
  }) {
    if (style == null) {
      return Container();
    }

    String? text = style.text(value);

    if (text == null) {
      return Container();
    }

    return fl.SideTitleWidget(
      axisSide: meta.axisSide,
      fitInside: fl.SideTitleFitInsideData.disable(),
      child: Text(
        text,
        style: style.textStyle,
        textAlign: style.textAlign,
      ),
    );
  }
}
