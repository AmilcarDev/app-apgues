class Record {
  int idetapa;
  double nota;

  Record({this.idetapa, this.nota});

  Record.map(dynamic obj) {
    this.idetapa = obj["idetapa"];
    this.nota = double.parse(obj["nota"]);
  }

  factory Record.fromJson(Map<String, dynamic> parsedJson) {
    return Record(idetapa: parsedJson["idetapa"], nota: parsedJson["nota"]);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["idetapa"] = idetapa;
    map["nota"] = nota;
    return map;
  }
}
