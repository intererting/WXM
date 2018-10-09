import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/sqlite/device_info_helper.dart';
import 'package:wxm/vm/main/sys_info_model.dart';

final String columnSdkInt = "sdkInt";

final String column_id = "_id";
final String column_appName = "appName";
final String column_resourceServerUrl = "resourceServerUrl";
final String column_appStoreId = "appStoreId";
final String column_appIosId = "appIosId";
final String column_appIosVersion = "appIosVersion";
final String column_appIosUpdFlag = "appIosUpdFlag";
final String column_appAndroidVersion = "appAndroidVersion";
final String column_appAndroidUpdFlag = "appAndroidUpdFlag";
final String column_androidDownloadUrl = "androidDownloadUrl";
final String column_userProtocolUrl = "userProtocolUrl";
final String column_dataServerUrl = "dataServerUrl";
final String column_webpageServerUrl = "webpageServerUrl";
final String column_splashImgUrl = "splashImgUrl";
final String column_aboutContent = "aboutContent";
final String column_appImg = "appImg";
final String column_updUserId = "updUserId";
final String column_updTime = "updTime";
final String column_userToken = "userToken";
final String column_customerServicePhone = "customerServicePhone";

//数据库管理类
class DbHelper {
  static final Map<String, DbHelper> singleton = new Map();
  Database db;

  factory DbHelper(String path) {
    if (singleton.containsKey(path)) {
      return singleton[path];
    } else {
      final dbHelper = new DbHelper._internal();
      singleton[path] = dbHelper;
      return dbHelper;
    }
  }

  DbHelper._internal() {}

  Future initDb(String path) async {
    db = await openDatabase(path, version: DB_VERSION,
        onCreate: (Database db, int version) async {
      //手机系统信息表
      await db.execute('''
create table $TABLE_DEVICE_INFO ( 
  $column_id integer primary key autoincrement, 
  sdkInt integer not null)
''');
      //软件系统信息表
      await db.execute('''
create table $TABLE_SYS_INFO ( 
  $column_id integer primary key autoincrement, 
  $column_resourceServerUrl text not null)
''');
    });
  }

  ///保存系统信息
  Future insertSysInfo(SysData sysData) async {
    if (null != db) {
      await db.delete(TABLE_SYS_INFO, where: null, whereArgs: null);
      db.insert(TABLE_SYS_INFO, <String, dynamic>{
        column_resourceServerUrl: sysData.resourceServerUrl
      });
    }
  }

  ///获取系统信息
  Future<SysData> getSysInfo() async {
    if (null != db) {
      List<Map> maps = await db.query(TABLE_SYS_INFO,
          columns: null, where: null, whereArgs: null);
      if (maps.isNotEmpty) {
        return new SysData.fromJson(maps.first);
      }
    }
  }

  ///保存设备信息
  Future insertDeviceInfo(DeviceInfo deviceInfo) async {
    if (null != db) {
      await db.delete(TABLE_DEVICE_INFO, where: null, whereArgs: null);
      db.insert(TABLE_DEVICE_INFO, deviceInfo.toMap());
    }
  }

  ///获取设备信息
  Future<DeviceInfo> getDeviceInfo() async {
    if (null != db) {
      List<Map> maps = await db.query(TABLE_DEVICE_INFO,
          columns: [columnSdkInt], where: null, whereArgs: null);
      if (maps.isNotEmpty) {
        return new DeviceInfo.fromMap(maps.first);
      }
    }
  }

  Future close() async {
    if (null != db) {
      db.close();
    }
  }
}
