import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wxm/constants/string_constant.dart';
import 'package:wxm/constants/wxm_colors.dart';
import 'package:wxm/vm/main/view/home_page.dart';
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
          canvasColor: WxmColors.bgColor,
          primaryColor: Colors.white,
          platform: TargetPlatform.iOS),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        HomePage.routeName: (context) => HomePage(),
        UserGuidePage.routeName: (context) => UserGuidePage(),
      },
    );
  }
}
