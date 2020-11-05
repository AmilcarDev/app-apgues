import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/models/MenuItemModel.dart';

class RecordDashboardPage extends StatefulWidget {
  @override
  _RecordDashboardPageState createState() => _RecordDashboardPageState();
}

class _RecordDashboardPageState extends State<RecordDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          "Expediente",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: barColor,
        centerTitle: true,
        actions: <Widget>[],
        elevation: 0.0,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            new MenuItemModel(
              icon: Icons.calendar_today,
              title: 'Cronograma',
              url: '/record/gantt',
              ctx: context,
            ),
            new MenuItemModel(
              icon: Icons.star_half,
              title: 'Notas Etapas',
              url: '/record/stages',
              ctx: context,
            ),
            new MenuItemModel(
              icon: Icons.description,
              title: 'Solicitudes',
              url: '/record/request',
              ctx: context,
            ),
          ],
        ),
      ),
    );
  }
}
