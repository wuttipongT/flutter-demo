import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:asset_mobile/model/drawer_item.dart';

class DefaultScreen extends StatefulWidget {
  final DrawerItem drawerItem;

  DefaultScreen({Key key, @required this.drawerItem}) : super(key: key);

  @override
  DefaultScreenState createState() {
    return new DefaultScreenState();
  }
}

class DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return new Scaffold(
//
//    )

    return new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              widget.drawerItem.icon,
              size: 54.0,
            ),
            new Text(
              widget.drawerItem.title,
              style: new TextStyle(fontSize: 48.0, fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }
}