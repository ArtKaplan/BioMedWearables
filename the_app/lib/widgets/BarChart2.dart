import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// taken from https://medium.com/@shashisalwathura/step-by-step-guide-to-creating-a-simple-bar-chart-in-flutter-21367ba75f7f

class SimpleBarChart extends StatefulWidget {
  final List<String> xAxisList;
  final String xAxisName;
  final List<double> yAxisList;
  final String yAxisName;
  final double interval;

  const SimpleBarChart(
      {super.key,
      required this.xAxisList,
      required this.yAxisList,
      required this.xAxisName,
      required this.yAxisName,
      required this.interval});

  @override
  State<SimpleBarChart> createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  late List<String> xAxisList;
  late List<double> yAxisList;
  late String xAxisName;
  late String yAxisName;
  late double interval;

  @override
  void initState() {
    super.initState();
    xAxisList = widget.xAxisList;
    yAxisList = widget.yAxisList;
    xAxisName = widget.xAxisName;
    yAxisName = widget.yAxisName;
    interval = widget.interval;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              xAxisName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) =>
                  bottomTitles(value, meta, xAxisList, context),
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: Text(
              yAxisName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 70,
              interval: interval,
              getTitlesWidget: (value, meta) => leftTitles(value, meta, context),
            ),
          ),
        ),
        borderData: FlBorderData(
          border: Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1, color:Theme.of(context).textTheme.titleLarge?.color ?? Colors.black),
            bottom: BorderSide(width: 1, color:Theme.of(context).textTheme.titleLarge?.color ?? Colors.black),
          ),
        ),
        gridData: FlGridData(show: false),
        barGroups: List.generate(
          xAxisList.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                  toY: yAxisList[index],
                  width: 15,
                  color: Theme.of(context).textTheme.labelMedium?.color,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
            ],
          ),
        ).toList(),
      ),
    );
  }
}

Widget bottomTitles(
    double value, TitleMeta meta, List<String> bottomTilesData, BuildContext context) {
  final Widget text = Text(
    bottomTilesData[value.toInt()],
    style: TextStyle(
      color: Theme.of(context).textTheme.titleLarge?.color,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  );

  return SideTitleWidget(
    meta: meta,
    space: 16, 
    child: text,
  );
}

Widget leftTitles(double value, TitleMeta meta, BuildContext context) {
  final formattedValue = (value).toStringAsFixed(0);
  final Widget text = Text(
    formattedValue,
    style: TextStyle(
      color: Theme.of(context).textTheme.titleLarge?.color,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  );

  return SideTitleWidget(
    meta: meta,
    space: 16, 
    child: text,
  );
}