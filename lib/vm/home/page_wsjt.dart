import 'package:flutter/cupertino.dart';
import 'package:wxm/constants.dart';

class WsjtPage extends StatefulWidget {
  static const String ROUTE_NAME = 'home/wsjt';

  @override
  _WsjtPageState createState() => _WsjtPageState();
}

class _WsjtPageState extends State<WsjtPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: WxmColors.bgColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text('万寿讲堂'),
      ),
      child: Text('xxx'),
    );
  }
}
