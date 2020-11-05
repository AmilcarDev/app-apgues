import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/gantt_chart.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/pages/menu.dart';

class GanttChartPage extends StatefulWidget {
  @override
  _GanttChartPageState createState() => _GanttChartPageState();
}

class _GanttChartPageState extends State<GanttChartPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cronograma'),
      ),
      drawer: new ApgMenu(),
      body: new GanttChart(
          fromDate: data.period.fromDate,
          toDate: data.period.toDate,
          data: data.period.stages,
          period: data.period),
    );
  }
}
