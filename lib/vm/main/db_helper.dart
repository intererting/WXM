import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';

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
  Database db;

  Future call(String path) async {
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

  Future close() async => db.close();
}
