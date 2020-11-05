import 'package:flutter/material.dart';
import 'package:pgues_app/models/data_model.dart';
import 'package:pgues_app/models/period_model.dart';
import 'package:pgues_app/models/request_model.dart';
import 'package:pgues_app/services/databse_service.dart';

var db = new DatabaseService();

var barColor = Color.fromRGBO(211, 47, 47, 1.0);
var bodyColor = Color.fromRGBO(239, 83, 80, 1.0);

AppModel data;
Period periodData;

List<dynamic> requestG;
getAllData() async {
  await db.getAllData();
  requestG = new List<dynamic>();
}

getPeriodData() async {
  await db.getPeriodData();
}

Future<void> getAllRequest() async {
  for (var record in data.period.records) {
    if (requestG.length <= data.period.records.length)
      requestG.add(getGroupRequest(record.idetapa));
  }
}

List<GroupRequest> getGroupRequest(int stage) {
  List<GroupRequest> gr = new List<GroupRequest>();
  Future.wait([db.getGroupRequests(stage)]).then((List responses) async {
    dynamic t = responses[0];
    for (var item in t) {
      gr.add(item);
      print('globals->' + item.toMap().toString());
    }
  });
  return gr;
}
