import 'package:flutter/material.dart';
import 'package:pgues_app/pages/about/AboutPage.dart';
import 'package:pgues_app/pages/gantt/GanttChartPage.dart';
import 'package:pgues_app/pages/home/HomePage.dart';
import 'package:pgues_app/pages/login/LoginPage.dart';
import 'package:pgues_app/pages/profile/ProfilePage.dart';
import 'package:pgues_app/pages/profile/UpdateProfile.dart';
import 'package:pgues_app/pages/record/RecordPage.dart';
import 'package:pgues_app/pages/record/record_dahboard.dart';
import 'package:pgues_app/pages/record/request_group.dart';

final routes = {
  '/': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/profile': (BuildContext context) => new ProfilePage(),
  '/record': (BuildContext context) => new RecordDashboardPage(),
  '/record/gantt': (BuildContext context) => new GanttChartPage(),
  '/record/stages': (BuildContext context) => new RecordPage(),
  '/record/request': (BuildContext context) => new GroupRequestPage(),
  '/about': (BuildContext context) => new AboutPage(),
  '/profile/update': (BuildContext context) => new UpdateProfilePage(),
};
