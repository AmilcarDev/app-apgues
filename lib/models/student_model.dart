class Student {
  int id = 1;
  String carnet;
  String careerName;
  String careerCode;
  String departmentName;
  String departmentCode;
  int year;
  int pera;
  int socialsHours;

  Student(
      {this.carnet,
      this.departmentCode,
      this.departmentName,
      this.careerCode,
      this.careerName,
      this.pera,
      this.socialsHours,
      this.year});

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        carnet: parsedJson['carnet'],
        departmentCode: parsedJson['departmentCode'],
        departmentName: parsedJson['departmentName'],
        careerCode: parsedJson['careerCode'],
        careerName: parsedJson['careerName'],
        year: parsedJson['year'],
        pera: parsedJson['pera'],
        socialsHours: parsedJson['socialsHours']);
  }
  Student.map(dynamic obj) {
    this.carnet = obj['carnet'];
    this.departmentCode = obj['departmentCode'];
    this.departmentName = obj['departmentName'];
    this.careerCode = obj['careerCode'];
    this.careerName = obj['careerName'];
    this.year = obj['year'];
    this.pera = obj['pera'];
    this.socialsHours = obj['socialsHours'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["carnet"] = carnet;
    map["departmentCode"] = departmentCode;
    map["departmentName"] = departmentName;
    map["careerCode"] = careerCode;
    map["careerName"] = careerName;
    map["year"] = year;
    map["pera"] = pera;
    map["socialsHours"] = socialsHours;

    return map;
  }
}
