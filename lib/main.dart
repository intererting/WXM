import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/view/wxm_theme.dart';
import 'package:wxm/vm/main/page_home.dart';
import 'package:wxm/vm/main/page_splash.dart';
import 'package:wxm/vm/main/page_user_guide.dart';

void main() => runZoned(() {
      runApp(new MyApp());
    }, onError: (dynamic error, dynamic stack) {
      print('MyAppError $error');
      print(stack);
    });

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: Colors.white, platform: TargetPlatform.iOS),
      builder: (BuildContext context, Widget child) {
        return WxmTheme(
          child: child,
        );
      },
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        HomePage.routeName: (context) => HomePage(),
        UserGuidePage.routeName: (context) => UserGuidePage(),
      },
    );
  }
}
