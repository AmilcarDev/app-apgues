import 'package:pgues_app/models/record_model.dart';
import 'package:pgues_app/models/stage_model.dart';

class Period {
  int id = 1;
  DateTime fromDate;
  DateTime toDate;
  String name;
  List<Stage> _stages;
  List<Record> _records;

  List<Stage> get stages => _stages;

  set stages(List<Stage> s) => _stages = s;

  List<Record> get records => _records;

  set records(List<Record> r) => _records = r;

  Period({this.fromDate, this.toDate, this.name});

  Period.map(dynamic obj) {
    this.name = obj["name"];
    // print("name: ${this.name}");
    this.fromDate = DateTime.parse(obj["fromDate"]);
    this.toDate = DateTime.parse(obj["toDate"]);
  }

  factory Period.fromJson(Map<String, dynamic> parsedJson) {
    return Period(
        name: parsedJson['name'],
        fromDate: DateTime.parse(parsedJson['fromDate']),
        toDate: DateTime.parse(parsedJson['toDate']));
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["fromDate"] = fromDate.toString();
    map["toDate"] = toDate.toString();
    return map;
  }
}
