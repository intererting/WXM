import 'package:wxm/vm/home/page_wsjt.dart';
import 'package:wxm/vm/home/tab_home.dart';
import 'package:wxm/vm/main/page_home.dart';
import 'package:flutter/material.dart';

class NavTest extends StatefulWidget {
  @override
  _NavTestState createState() => _NavTestState();
}

class _NavTestState extends State<NavTest> {
  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: 'home/tab_home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home/tab_home':
            builder = (BuildContext _) => new TabHome();
            break;
          case WsjtPage.ROUTE_NAME:
            builder = (BuildContext _) => new WsjtPage();
            break;
          default:
            throw new Exception('Invalid route: ${settings.name}');
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
