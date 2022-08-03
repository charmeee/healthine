import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class InbodyChart extends StatefulWidget {
  InbodyChart({Key? key}) : super(key: key);

  @override
  State<InbodyChart> createState() => _InbodyChartState();
}

class _InbodyChartState extends State<InbodyChart> {
  final List<ChartData> chartData = [
    ChartData('체중', 50),
    ChartData('체지방량', 18),
    ChartData('골격근량', 23),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 200,
            child: SfCartesianChart(
              series: <ChartSeries>[
                BarSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    // Width of the bars
                    width: 0.6,
                    // Spacing between the bars
                    spacing: 0.3)
              ],
              primaryXAxis: CategoryAxis(),
            )));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
