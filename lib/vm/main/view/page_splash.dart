import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:wxm/sqlite/device_info_helper.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/vm/main/view/page_mixins.dart';

import 'base_stateful_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> with PageMixins {
  DeviceInfoPlugin _deviceInfo = new DeviceInfoPlugin();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
    _timer = Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
          ),
        ),
        Scaffold(
            body: Image(
          image: AssetImage('images/splash.png'),
          fit: BoxFit.fill,
          width: screenWidth,
          height: screenHeight,
        )),
      ],
    );
  }

  Future<Null> _getDeviceInfo() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    var databasesPath = await getDatabasesPath();
    String path = Path.join(databasesPath, "wxm.db");
    DeviceInfo deviceInfo = DeviceInfo(sdkInt: androidInfo.version.sdkInt);
    DeviceInfoHelper helper = DeviceInfoHelper();
    await helper(path);
    await helper.insert(deviceInfo);
    helper.close();
  }

  @override
  void dispose() {
    super.dispose();
    if (null != _timer) {
      _timer.cancel();
      _timer = null;
    }
  }
}
