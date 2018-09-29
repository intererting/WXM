import 'package:flutter/cupertino.dart';

class TabMessage extends StatefulWidget {
  @override
  _TabMessageState createState() => _TabMessageState();
}

class _TabMessageState extends State<TabMessage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text('TabMessage'));
  }
}
