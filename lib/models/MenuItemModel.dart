import 'package:flutter/material.dart';

class MenuItemModel extends StatelessWidget {
  final IconData icon;
  final String title;
  final BuildContext ctx;
  final String url;
  MenuItemModel({this.icon, this.title, this.url, this.ctx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigator.of(ctx).pop();
          Navigator.of(ctx).pushNamed(url);
        },
        splashColor: Colors.red[400],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70.0,
              ),
              Text(
                title,
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
