import 'package:flutter/material.dart';

class WxmTheme extends InheritedWidget {
  final String serverResourceUrl = "";

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  WxmTheme({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static WxmTheme of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(WxmTheme);
}
