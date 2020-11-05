import 'package:flutter/material.dart';
import 'package:pgues_app/models/MenuItemModel.dart';
import 'package:pgues_app/pages/menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Inicio'),
      ),
      drawer: new ApgMenu(),
      body: new Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            // new MenuItemModel(
            //   icon: Icons.home,
            //   title: 'Inicio',
            //   url: '/home',
            //   ctx: context,
            // ),
            new MenuItemModel(
              icon: Icons.person_outline,
              title: 'Datos Personales',
              url: '/profile',
              ctx: context,
            ),
            new MenuItemModel(
              icon: Icons.calendar_today,
              title: 'Expediente',
              url: '/record',
              ctx: context,
            ),
            new MenuItemModel(
              icon: Icons.info,
              title: 'Acerca de',
              url: '/about',
              ctx: context,
            ),
          ],
        ),
      ),
    );
  }
}
