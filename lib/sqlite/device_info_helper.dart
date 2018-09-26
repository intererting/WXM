import 'dart:async';

import 'package:sqflite/sqflite.dart';

final String tableName = "t_device_info";
final String columnId = "_id";
final String columnSdkInt = "sdkInt";

class DeviceInfo {
  int id;
  int sdkInt;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnSdkInt: sdkInt,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  DeviceInfo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    sdkInt = map[columnSdkInt];
  }

  DeviceInfo({this.sdkInt});
}

class DeviceInfoHelper {
  Database db;

  Future call(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableName ( 
  $columnId integer primary key autoincrement, 
  $columnSdkInt integer not null)
''');
    });
  }

  Future insert(DeviceInfo deviceInfo) async {
    await db.delete(tableName, where: null, whereArgs: null);
    await db.insert(tableName, deviceInfo.toMap());
  }

  Future<DeviceInfo> getDeviceInfo() async {
    List<Map> maps = await db.query(tableName,
        columns: [columnSdkInt], where: null, whereArgs: null);
    if (maps.length > 0) {
      return new DeviceInfo.fromMap(maps.first);
    }
    return null;
  }

  Future close() async => db.close();
}
