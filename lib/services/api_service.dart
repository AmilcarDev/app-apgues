import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/models/data_model.dart';
import 'package:pgues_app/models/person_model.dart';
import 'package:pgues_app/models/period_model.dart';
import 'package:pgues_app/models/record_model.dart';
import 'package:pgues_app/models/stage_model.dart';
import 'package:pgues_app/models/user_model.dart';
import 'package:pgues_app/models/request_model.dart';
import 'package:pgues_app/Utils/network_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'databse_service.dart';

class ApiService {
  NetworkUtil _netUtil = new NetworkUtil();
  // SERVER IP
  static final iP = "http://168.232.51.105";
  // LOCAL IP
//  static final iP = "http://192.168.1.8:8080";
  static final imageUrl = "$iP/storage/fotos/";
  static final baseUrl = "$iP/api/v1";
  static final loginUrl = baseUrl + "/login?";
  static final reloadDataUrl = baseUrl + '/get_user_details?api_token=';
  static final updateDataUrl = baseUrl + '/update_user_details?api_token=';
  static final getDataGanttChart = baseUrl + '/get_dates?api_token=';

  Future<AppModel> login(String username, String password) {
    return _netUtil
        .get(loginUrl + 'email=' + username + '&password=' + password)
        .then((dynamic res) async {
      print(res);
      if (res["error"]) throw res["error_msg"];
      var db = new DatabaseService();
      List<Stage> st = new List<Stage>();
      dynamic s = res["stages"];
      for (dynamic stageObj in s) {
        Stage sa = new Stage.fromJson(stageObj);
        st.add(sa);
      }
      List<Record> rc = new List<Record>();
      dynamic r = res["stages_records"];
      for (dynamic stageObj in r) {
        Record sa = new Record.map(stageObj);
        rc.add(sa);
      }
      dynamic p = res["period"];
      Period _period = new Period.map(p[0]);

      List<GroupRequest> gr = new List<GroupRequest>();
      dynamic req = res["solicitudes"];

      for (dynamic g in req) {
        GroupRequest grs = new GroupRequest.fromJson(g);
        gr.add(grs);
      }
      await db.savePeriod(_period);
      await db.saveStage(st);
      await db.saveRecords(rc);
      await db.saveGroupRequest(gr);
      return new AppModel.map(res);
    }).catchError((e){
      throw "Imposible contactar con el servidor";
    });
  }

  Future<User> reloadData(String apikey) {
    return _netUtil.get(reloadDataUrl + apikey).then((dynamic res) {
      if (res["error"]) throw res["error_msg"];
      return new User.map(res);
    }).catchError((e){
      throw "Imposible contactar con el servidor";
    });
  }

  Future<bool> updateData(String apikey, String email, String phone) {
    print("$apikey $email $phone");
    return _netUtil
        .get(updateDataUrl + apikey + '&email=' + email + '&phone=' + phone)
        .then((dynamic res) {
      // print(res.toString());
      data.person = Person.map(res);
      data.user = User.map(res);
      // print(res);
      if (res["error"]) throw res["error_msg"];
      Fluttertoast.showToast(
        msg: "Los datos han sido actualizados",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
      return !res["error"];
    }).catchError((e){
      throw "Imposible contactar con el servidor";
    });
  }
}
