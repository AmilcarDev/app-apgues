class Person {
  int id = 1;
  String name;
  String lastname;
  String address;
  int sex;
  String birthday;
  String dui;
  String phone;
  String photo;
  Person(
      {this.name,
      this.lastname,
      this.address,
      this.sex,
      this.birthday,
      this.dui,
      this.phone,
      this.photo});

  Person.map(dynamic obj) {
    this.name = obj['name'];
    this.lastname = obj['lastname'];
    this.address = obj['address'];
    this.sex = obj['sex'];
    this.birthday = obj['birthday'];
    this.dui = obj['dui'];
    this.phone = obj['phone'];
    this.photo = obj['photo'];
  }

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    return Person(
        name: parsedJson['name'],
        lastname: parsedJson['lastname'],
        address: parsedJson['address'],
        sex: parsedJson['sex'],
        birthday: parsedJson['birthday'],
        dui: parsedJson['dui'],
        phone: parsedJson['phone'],
        photo: parsedJson['photo']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["lastname"] = lastname;
    map["address"] = address;
    map["sex"] = sex;
    map["birthday"] = birthday;
    map["dui"] = dui;
    map["phone"] = phone;
    map["photo"] = photo;
    return map;
  }
}
