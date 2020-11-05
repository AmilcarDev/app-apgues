import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/pages/menu.dart';
import 'package:pgues_app/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApiService api;

  _ProfilePageState() {
    api = new ApiService();
  }

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 64.0,
          backgroundColor: Colors.transparent,
          backgroundImage: new CachedNetworkImageProvider(
              ApiService.imageUrl + data.person.photo),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${data.person.name} ${data.person.lastname}',
        style: TextStyle(
            fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );

    final dataInfo = ListView(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      key: PageStorageKey("Profile 1"),
      children: <Widget>[
        welcome,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Carnet:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              '${data.student.carnet}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sexo:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              (data.person.sex == 1) ? 'Masculino' : 'Femenino',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Telefono:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              '${data.person.phone}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Dirección: ",
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text("${data.person.address}",
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha de Nacimiento:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              '${data.person.birthday}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dui:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              '${data.person.dui}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correo:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              '${data.user.email}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
            ),
          ],
        ),
      ],
    );

    final body = SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
        physics: AlwaysScrollableScrollPhysics(),
        key: PageStorageKey("Profile 1"),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 24.0, left: 24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.red,
                Colors.redAccent,
              ]),
            ),
            child: Column(
              children: <Widget>[alucard, dataInfo],
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      backgroundColor: barColor,
      appBar: new AppBar(
        title: new Text(
          'Mi Perfil',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: bodyColor,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/profile/update");
            },
          ),
        ],
      ),
      drawer: new ApgMenu(),
      body: body,
    );
  }
}
