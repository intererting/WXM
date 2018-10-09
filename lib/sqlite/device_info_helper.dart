import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/sqlite/db_helper.dart';

class DeviceInfo {
  int id;
  int sdkInt;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnSdkInt: sdkInt,
    };
    return map;
  }

  DeviceInfo.fromMap(Map<String, dynamic> map) {
    id = map[column_id];
    sdkInt = map[columnSdkInt];
  }

  DeviceInfo({this.sdkInt});
}

class DeviceInfoHelper {
  Database db;

  Future call(String path) async {
    db = await openDatabase(path);
  }

  Future insert(DeviceInfo deviceInfo) async {
    await db.delete(TABLE_DEVICE_INFO, where: null, whereArgs: null);
    await db.insert(TABLE_DEVICE_INFO, deviceInfo.toMap());
  }

  Future<DeviceInfo> getDeviceInfo() async {
    List<Map> maps = await db.query(TABLE_DEVICE_INFO,
        columns: [columnSdkInt], where: null, whereArgs: null);
    if (maps.length > 0) {
      return new DeviceInfo.fromMap(maps.first);
    }
    return null;
  }

  Future close() async => db.close();
}
