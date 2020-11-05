import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/models/data_model.dart';
import 'package:pgues_app/models/period_model.dart';
import 'package:pgues_app/models/person_model.dart';
import 'package:pgues_app/models/record_model.dart';
import 'package:pgues_app/models/stage_model.dart';
import 'package:pgues_app/models/student_model.dart';
import 'package:pgues_app/models/user_model.dart';
import 'package:pgues_app/models/request_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = new DatabaseService.internal();
  factory DatabaseService() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseService.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'maina.db');
    print(path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER, username TEXT, email TEXT, api_token TEXT)");
    await db.execute(
        "CREATE TABLE Person(id INTEGER, name TEXT, lastname TEXT, address TEXT, sex INTEGER, birthday TEXT, dui TEXT, phone TEXT, photo TEXT)");
    await db.execute(
        "CREATE TABLE Student(id INTEGER, carnet TEXT,departmentCode TEXT,departmentName TEXT,careerCode TEXT,careerName TEXT,pera INTEGER, socialsHours INTEGER,year INTEGER)");
    await db.execute(
        "CREATE TABLE Period(id INTEGER, name TEXT, fromDate TEXT, toDate TEXT)");
    await db.execute(
        "CREATE TABLE Stage(id INTEGER, name TEXT, startTime TEXT, endTime TEXT, percent INT)");
    await db.execute("CREATE TABLE Record(idetapa INTEGER, nota TEXT)");
    await db
        .execute("CREATE TABLE Request(name TEXT, stage INTEGER, sendTo TEXT)");
    print("Created tables");
  }

  Future<User> getUser() async {
    final dbClient = await db;
    var res = await dbClient.query("User", where: "id = ?", whereArgs: [1]);
    return res.isNotEmpty ? new User.map(res.first) : Null;
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> updateUser(User user) async{
    var dbClient = await db;
    int res = await dbClient.update("User",user.toMap(),where: "id = ?",whereArgs: [user.id],);
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0 ? true : false;
  }

  Future<int> saveStudent(Student student) async {
    var dbClient = await db;
    int res = await dbClient.insert("Student", student.toMap());
    return res;
  }

  Future<int> deleteStudents() async {
    var dbClient = await db;
    int res = await dbClient.delete("Student");
    return res;
  }

  Future<Student> getStudent() async {
    final dbClient = await db;
    var res = await dbClient.query("Student", where: "id = ?", whereArgs: [1]);
    // print(res);
    return res.isNotEmpty ? new Student.map(res.first) : Null;
  }

  Future<void> getAllData() async {
    Future.wait([getUser(), getPerson(), getStudent()])
        .then((List responses) async {
      data = new AppModel(responses[0], responses[2], responses[1]);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future<void> getPeriodData() async {
    Future.wait([getPeriod(), getStages(), getRecords()])
        .then((List responses) async {
      Period pe = responses[0];
      pe.stages = responses[1];
      pe.records = responses[2];
      data.period = pe;

      getAllRequest();
    });
  }

  Future<Person> getPerson() async {
    final dbClient = await db;
    var res = await dbClient.query("Person", where: "id = ?", whereArgs: [1]);
    return res.isNotEmpty ? new Person.map(res.first) : Null;
  }

  Future<int> savePerson(Person person) async {
    var dbClient = await db;
    int res = await dbClient.insert("Person", person.toMap());
    return res;
  }

  Future<int> updatePerson(Person person) async{
    var dbClient = await db;
    int res = await dbClient.update("Person",person.toMap(),where: "id = ?",whereArgs: [person.id],);
    return res;
  }

  Future<int> deletePersons() async {
    var dbClient = await db;
    int res = await dbClient.delete("Person");
    return res;
  }

  Future<List<Stage>> getStages() async {
    List<Stage> st = new List<Stage>();
    var dbClient = await db;
    var res = await dbClient.query("Stage", orderBy: "id");
    for (var stageObj in res) {
      st.add(new Stage.map(stageObj));
    }
    return res.isNotEmpty ? st : Null;
  }

  Future<int> saveStage(List<Stage> st) async {
    int res;
    var dbClient = await db;
    for (Stage stage in st) {
      res = await dbClient.insert('Stage', stage.toMap());
    }
    return res;
  }

  Future<int> deleteStages() async {
    var dbClient = await db;
    int res = await dbClient.delete("Stage");
    return res;
  }

  Future<Period> getPeriod() async {
    final dbClient = await db;
    var res = await dbClient.query("Period", where: "id = ?", whereArgs: [1]);
    return res.isNotEmpty ? new Period.map(res.first) : Null;
  }

  Future<int> savePeriod(Period period) async {
    var dbClient = await db;
    int res = await dbClient.insert("Period", period.toMap());
    return res;
  }

  Future<int> deletePeriod() async {
    var dbClient = await db;
    int res = await dbClient.delete("Period");
    return res;
  }

  Future<List<Record>> getRecords() async {
    List<Record> st = new List<Record>();
    var dbClient = await db;
    var res = await dbClient.query("Record", orderBy: "idetapa");
    for (var stageObj in res) {
      st.add(new Record.map(stageObj));
    }
    return res.isNotEmpty ? st : new List<Record>();
  }

  Future<int> saveRecords(List<Record> st) async {
    int res;
    var dbClient = await db;
    for (Record stage in st) {
      res = await dbClient.insert('Record', stage.toMap());
    }
    return res;
  }

  Future<int> deleteRecords() async {
    var dbClient = await db;
    int res = await dbClient.delete("Record");
    return res;
  }

  Future<List<GroupRequest>> getGroupRequests(int stage) async {
    var dbClient = await db;
    List<GroupRequest> st = new List<GroupRequest>();
    var res =
        await dbClient.query("Request", where: "stage = ?", whereArgs: [stage]);
    if (res.isNotEmpty) {
      for (var stageObj in res) {
        GroupRequest grq = new GroupRequest.map(stageObj);
        st.add(grq);
      }
    }
    return st;
  }

  Future<int> saveGroupRequest(List<GroupRequest> st) async {
    int res;
    var dbClient = await db;
    for (GroupRequest request in st) {
      res = await dbClient.insert('Request', request.toMap());
      print(request.toMap());
    }
    return res;
  }

  Future<int> deleteGroupRequest() async {
    var dbClient = await db;
    int res = 0;
    res = await dbClient.delete("Request");
    return res;
  }
}
