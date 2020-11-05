import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/pages/menu.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Acerca de",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: barColor,
        centerTitle: true,
        actions: <Widget>[],
        elevation: 0.0,
      ),
      drawer: new ApgMenu(),
      body: Center(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
            physics: AlwaysScrollableScrollPhysics(),
            key: PageStorageKey("About Page 1"),
            children: <Widget>[
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 64.0,
                  child: Image.asset('assets/minerva.png'),
                ),
              ),
              new Text(
                "APGUES",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.0),
              Text(
                "Aplicación para el Control de Procesos de Graduación en la Facultad Multidisciplinaria Paracentral de la Universidad de El Salvador",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 78.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: 75.0,
                  width: double.infinity,
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Universidad de El Salvador',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '© Copyright 2019',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black26),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
