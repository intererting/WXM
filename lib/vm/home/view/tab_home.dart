import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wxm/utis.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: new CustomScrollView(slivers: <Widget>[
        new SliverList(
            delegate: SliverChildListDelegate(<Widget>[Text('xxxx')]))
      ]),
    );
  }
}
