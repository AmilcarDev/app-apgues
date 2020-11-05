import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/Utils/table_request.dart';
import 'package:pgues_app/pages/about/error_page.dart';

class GroupRequestPage extends StatefulWidget {
  @override
  _GroupRequestPageState createState() => _GroupRequestPageState();
}

class _GroupRequestPageState extends State<GroupRequestPage> {
  var icons = [
    Icon(Icons.filter_1),
    Icon(Icons.filter_2),
    Icon(Icons.filter_3)
  ];

  @override
  Widget build(BuildContext context) {
    try {
      List<Widget> tabs = new List<Widget>();
    List<TableRequest> tabBodies = new List<TableRequest>();
    for (var record in data.period.records) {
      tabs.add(Tab(
        text: data.period.stages[record.idetapa - 1].name,
        icon: icons[record.idetapa - 1],
      ));
      tabBodies.add(new TableRequest(
        record.idetapa,
      ));
    }
    return SafeArea(
      child: DefaultTabController(
        length: data.period.records.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: tabs,
            ),
            title: Text('Solicitudes'),
          ),
          body: TabBarView(
            children: tabBodies,
          ),
        ),
      ),
    );
    } catch (e) {
     throw 'Error';
    }
  }
}
