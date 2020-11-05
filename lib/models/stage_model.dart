class Stage {
  String name;
  DateTime startTime;
  DateTime endTime;
  int id;
  int percent;

  Stage({this.name, this.startTime, this.endTime, this.id, this.percent});

  Stage.map(dynamic obj) {
    this.name = obj["name"];
    this.startTime = DateTime.parse(obj["startTime"]);
    this.endTime = DateTime.parse(obj["endTime"]);
    this.id = obj["order"];
    this.percent = obj["percent"];
  }

  factory Stage.fromJson(Map<String, dynamic> parsedJson) {
    return Stage(
        name: parsedJson['name'],
        startTime: DateTime.parse(parsedJson['startTime']),
        id: parsedJson['order'],
        percent: int.parse(parsedJson["percent"]),
        endTime: DateTime.parse(parsedJson['endTime']));
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = this.name;
    map["startTime"] = this.startTime.toString();
    map["endTime"] = this.endTime.toString();
    map["id"] = this.id;
    map["percent"] = this.percent;
    return map;
  }
}
