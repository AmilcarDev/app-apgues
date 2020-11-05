import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/services/api_service.dart';

class ApgMenu extends StatelessWidget {
  void _logout() {
    db.deleteUsers();
    db.deletePersons();
    db.deleteStudents();
    db.deletePeriod();
    db.deleteStages();
    db.deleteRecords();
    db.deleteGroupRequest();
    requestG = null;
    periodData = null;
    data = null;
  }

  BuildContext _ctx;
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName:
                new Text('${data.person.name} ${data.person.lastname}'),
            accountEmail: new Text(data.user.email),
            currentAccountPicture: CircleAvatar(
              radius: 64.0,
              backgroundColor: Colors.transparent,
              backgroundImage: new CachedNetworkImageProvider(
                  ApiService.imageUrl + data.person.photo),
            ),
          ),
          new ListTile(
            title: new Text('Inicio'),
            onTap: () {
              Navigator.of(_ctx).pop();
              Navigator.of(_ctx).pushNamed("/home");
            },
          ),
          new ListTile(
            title: new Text('Mi Perfil'),
            onTap: () {
              Navigator.of(_ctx).pop();
              Navigator.of(_ctx).pushNamed("/profile");
            },
          ),
          new ListTile(
            title: new Text('Expediente'),
            onTap: () {
              Navigator.of(_ctx).pop();
              Navigator.of(_ctx).pushNamed("/record");
            },
          ),
          new ListTile(
            title: new Text('Acerca de'),
            onTap: () {
              Navigator.of(_ctx).pop();
              Navigator.of(_ctx).pushNamed("/about");
            },
          ),
          new ListTile(
            title: new Text('Cerrar Sesion'),
            onTap: () {
              Navigator.of(_ctx).pop();
              _logout();
              Navigator.of(_ctx).pushNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}
