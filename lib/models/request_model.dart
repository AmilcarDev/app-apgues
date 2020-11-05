class GroupRequest {
  String name;
  int stage;
  String sendTo;

  GroupRequest({this.name, this.stage, this.sendTo});

  GroupRequest.map(dynamic obj) {
    this.name = obj["name"];
    this.stage = (obj["stage"]);
    this.sendTo = obj["sendTo"];
  }

  factory GroupRequest.fromJson(Map<String, dynamic> parsedJson) {
    return GroupRequest(
        name: parsedJson['name'],
        stage: parsedJson['stage'],
        sendTo: parsedJson['sendTo']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = this.name;
    map["stage"] = this.stage;
    map["sendTo"] = this.sendTo;
    return map;
  }
}
