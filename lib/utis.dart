import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/sqlite/device_info_helper.dart';
import 'package:wxm/vm/main/sys_info_model.dart';

//状态栏的高度
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double get screenWidth => MediaQueryData.fromWindow(ui.window).size.width;

double get screenHeight => MediaQueryData.fromWindow(ui.window).size.height;

Future<String> getDbPath() async {
  var databasesPath = await getDatabasesPath();
  return join(databasesPath, DB_NAME);
}

///格式化资源地址
Future<String> formatUrl(String baseUrl) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "wxm.db");
  SysInfoHelper helper = SysInfoHelper();
  await helper(path);
  SysData sysData = await helper.getSysInfo();
  return '${sysData.resourceServerUrl}$baseUrl';
}
