import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class _DemoState extends State<Demo> {
  final List<ChartData> chartData = [
    ChartData('David', 30, Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Mark', 38, Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Test', 34, Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Test', 52, Color.fromRGBO(255, 189, 57, 1))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.grey,
            height: 250,
            width: 500,
            child: SfCircularChart(
                margin: EdgeInsets.all(0),
                legend: Legend(isVisible: true, position: LegendPosition.right),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Container(child: const Text('Annotation')),
                    radius: '2%',
                    verticalAlignment: ChartAlignment.far,
                  ),
                ],
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                      dataLabelMapper: (ChartData data, _) =>
                          "${data.y.toInt()} %",
                      dataSource: chartData,
                      enableSmartLabels: true,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      radius: '70%',
                      innerRadius: '65%',
                      startAngle: 270, // Starting angle of doughnut
                      endAngle: 90,
                      dataLabelSettings: DataLabelSettings(
                          // Renders the data label
                          isVisible: true),

                      // Corner style of doughnut segment
                      cornerStyle: CornerStyle.bothCurve)
                ])),
      ),
    );
  }
}
