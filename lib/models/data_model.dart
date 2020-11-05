import 'package:pgues_app/models/period_model.dart';
import 'package:pgues_app/models/person_model.dart';
import 'package:pgues_app/models/student_model.dart';
import 'package:pgues_app/models/user_model.dart';
import 'package:pgues_app/models/request_model.dart';

class AppModel {
  User _user;
  Student _student;
  Person _person;
  Period _period;
  List<GroupRequest> _groupRequest;

  AppModel(User user, Student student, Person person) {
    this._user = user;
    this._student = student;
    this._person = person;
    // this._period = period;
  }

  AppModel.map(dynamic obj) {
    this._user = User.map(obj);
    this._student = Student.map(obj);
    this._person = Person.map(obj);
  }

  User get user => _user;
  Student get student => _student;
  Person get person => _person;
  Period get period => _period;
  List<GroupRequest> get groupRequest => _groupRequest;

  set period(Period p) => _period = p;
  set person(Person p) => _person = p;
  set user(User u) => _user = u;
  set groupRequest(List<GroupRequest> g) => _groupRequest = g;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = _user;
    map["person"] = _person;
    map["student"] = _student;
    return map;
  }
}
