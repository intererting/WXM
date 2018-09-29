import 'package:flutter/cupertino.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text('tabHome'));
  }
}
