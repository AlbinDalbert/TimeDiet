import 'package:numberpicker/numberpicker.dart';
import 'package:todo_list/settingsView.dart';
import 'WorkList/tasks.dart';
import 'WorkList/taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'WorkList/workList.dart';
import 'drawer.dart';
import 'background.dart';

//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<_SalesData> data = [
    _SalesData('Mo', 35),
    _SalesData('Tu', 28),
    _SalesData('We', 34),
    _SalesData('Th', 32),
    _SalesData('Fr', 40),
    _SalesData('Sa', 37),
    _SalesData('Su', 23)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainBackground(),
        Column(children: [
          Container(
              child: const Center(
                  child: Text('TimEDieT',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold))),
              margin: const EdgeInsets.only(top: 50)),
          AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                //color: Colors.black26,
                child: Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white38, width: 4),
                        left: BorderSide(color: Colors.white38, width: 4),
                        right: BorderSide(color: Colors.white38, width: 4),
                        bottom: BorderSide(color: Colors.white38, width: 4)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(112, 160, 255, 0.8),
                        Color.fromRGBO(63, 81, 181, 0.8),
                      ],
                    ),
                  ),
                  //),
                  //Initialize the spark charts widget

                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => data[index].year,
                    yValueMapper: (int index) => data[index].sales,
                    dataCount: 7,
                    color: Colors.amber,
                  ),
                )),
              ))
        ]),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
