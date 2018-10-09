import 'dart:async';
import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:permission/permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/sqlite/db_helper.dart';
import 'package:wxm/sqlite/device_info_helper.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/view/base_stateful_widget.dart';
import 'package:wxm/view/page_mixins.dart';
import 'package:wxm/vm/main/page_home.dart';
import 'package:wxm/vm/main/page_user_guide.dart';
import 'package:wxm/vm/main/sys_info_model.dart';

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
    _initPermission();
    _initDatabase();
    _timer = Timer(Duration(milliseconds: 3000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool pass = prefs.getBool(SpConstant.SP_PASS_GUIDE);
      if (pass != null && pass) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(UserGuidePage.routeName);
      }
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

  @override
  void dispose() {
    super.dispose();
    if (null != _timer) {
      _timer.cancel();
      _timer = null;
    }
  }

  ///初始表
  Future<Null> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = Path.join(databasesPath, DB_NAME);
    DbHelper helper = DbHelper(path);
    await helper.initDb(path);
    //获取系统信息
    String dataURL = '${WebConstant.RESTFUL_SERVICE_HOST_WWW}getSysInfo';
    http.Response response = await http.post(dataURL);
    helper.insertSysInfo(SysInfo.fromJson(json.decode(response.body)).data);
    //获取设备信息
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    DeviceInfo deviceInfo = DeviceInfo(sdkInt: androidInfo.version.sdkInt);
    helper.insertDeviceInfo(deviceInfo);
  }

  ///申请权限
  _initPermission() {
    Permission.requestSinglePermission(PermissionName.Storage);
  }
}
