import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wxm/constant.dart';
import 'package:wxm/vm/home/view/home_page.dart';
import 'package:wxm/vm/main/view/page_splash.dart';
import 'package:wxm/vm/main/view/page_user_guide.dart';

void main() => runZoned(() {
      runApp(new MyApp());
    }, onError: (dynamic error, dynamic stack) {
      print('MyAppError $error');
      print(stack);
    });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: bgColor,
          primaryColor: Colors.white,
          platform: TargetPlatform.iOS),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/guide': (context) => UserGuidePage(),
      },
    );
  }
}
