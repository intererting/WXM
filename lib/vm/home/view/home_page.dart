import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wxm/sqlite/device_info_helper.dart';
import 'package:wxm/vm/main/view/base_stateful_widget.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("save"),
              onPressed: () {
              }),
          RaisedButton(
              child: Text("get"),
              onPressed: () {
                _testGetDb();
              })
        ],
      ),
    );
//    return Theme(
//      data:
//          Theme.of(context).copyWith(primaryColorBrightness: Brightness.light),
//      child: Scaffold(
//        body: Text("xxx"),
//      ),
//    );
  }

  _testGetDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "wxm.db");
    DeviceInfoHelper helper = DeviceInfoHelper();
    await helper(path);
    await helper.getDeviceInfo().then((DeviceInfo device) {
      print('sdkInt ${device.sdkInt}');
    });
  }
}
