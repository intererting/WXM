import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/view/base_stateful_widget.dart';
import 'package:wxm/vm/classify/view/tab_classify.dart';
import 'package:wxm/vm/home/tab_home.dart';
import 'package:wxm/vm/message/view/tab_message.dart';
import 'package:wxm/vm/mine/view/tab_mine.dart';
import 'package:wxm/vm/shoppingcar/view/tab_shoppingcar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(
          fontSize: 15.0,
          color: WxmColors.commonBlackColor,
        ),
        child: SafeArea(
          bottom: false,
          top: false,
          child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                  inactiveColor: Colors.grey,
                  backgroundColor: Colors.white,
                  iconSize: 23.0,
                  activeColor: WxmColors.commonBlackColor,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage('images/tab_home.png')),
                        title: Text(
                          '首页',
                        )),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage('images/tab_classify.png')),
                        title: Text(
                          '分类',
                        )),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage('images/tab_message.png')),
                        title: Text(
                          '消息',
                        )),
                    BottomNavigationBarItem(
                        icon:
                            ImageIcon(AssetImage('images/tab_shoping_car.png')),
                        title: Text(
                          '购物车',
                        )),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage('images/tab_mine.png')),
                        title: Text(
                          '我的',
                        ))
                  ]),
              tabBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return TabHome();
                } else if (index == 1) {
                  return TabClassify();
                } else if (index == 2) {
                  return TabMessage();
                } else if (index == 3) {
                  return TabShoppingCar();
                } else if (index == 4) {
                  return TabMine();
                }
              }),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
