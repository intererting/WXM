import 'package:flutter/cupertino.dart';
import 'package:wxm/constants.dart';
import 'package:flutter/material.dart';

class WsjtPage extends StatefulWidget {
  static const String ROUTE_NAME = 'home/wsjt';

  @override
  _WsjtPageState createState() => _WsjtPageState();
}

class _WsjtPageState extends State<WsjtPage> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        value: 0.0, duration: new Duration(milliseconds: 200), vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: WxmColors.bgColor,
        navigationBar: CupertinoNavigationBar(
          middle: Text('万寿讲堂'),
        ),
        child: SafeArea(
          child: new DefaultTextStyle(
            style: TextStyle(
                fontSize: COMMON_TEXT_SIZE, color: WxmColors.commonBlackColor),
            child: Scaffold(
              body: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        indicatorPadding: EdgeInsets.symmetric(horizontal: -10.0),
                        labelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.grey,
                        tabs: <Widget>[
                          Tab(
                            text: 'xxx',
                          ),
                          Tab(
                            text: 'yyyy',
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(children: [Text("xxx"), Text("yyy")]),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
