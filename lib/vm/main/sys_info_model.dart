import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/vm/main/db_helper.dart';

class SysInfo {
  String resultCode;
  String resultMsg;
  String resultCount;
  SysData data;

  SysInfo({this.resultCode, this.resultMsg, this.resultCount, this.data});

  SysInfo.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
    resultCount = json['resultCount'];
    data = json['data'] != null ? new SysData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    data['resultCount'] = this.resultCount;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SysData {
  String appName;
  String appStoreId;
  String appIosId;
  String appIosVersion;
  String appIosUpdFlag;
  String appAndroidVersion;
  String appAndroidUpdFlag;
  String androidDownloadUrl;
  String userProtocolUrl;
  String dataServerUrl;
  String resourceServerUrl;
  String webpageServerUrl;
  String splashImgUrl;
  String aboutContent;
  String appImg;
  int updUserId;
  String updTime;
  String userToken;
  String customerServicePhone;

  SysData(
      {this.appName,
      this.appStoreId,
      this.appIosId,
      this.appIosVersion,
      this.appIosUpdFlag,
      this.appAndroidVersion,
      this.appAndroidUpdFlag,
      this.androidDownloadUrl,
      this.userProtocolUrl,
      this.dataServerUrl,
      this.resourceServerUrl,
      this.webpageServerUrl,
      this.splashImgUrl,
      this.aboutContent,
      this.appImg,
      this.updUserId,
      this.updTime,
      this.userToken,
      this.customerServicePhone});

  SysData.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appStoreId = json['appStoreId'];
    appIosId = json['appIosId'];
    appIosVersion = json['appIosVersion'];
    appIosUpdFlag = json['appIosUpdFlag'];
    appAndroidVersion = json['appAndroidVersion'];
    appAndroidUpdFlag = json['appAndroidUpdFlag'];
    androidDownloadUrl = json['androidDownloadUrl'];
    userProtocolUrl = json['userProtocolUrl'];
    dataServerUrl = json['dataServerUrl'];
    resourceServerUrl = json['resourceServerUrl'];
    webpageServerUrl = json['webpageServerUrl'];
    splashImgUrl = json['splashImgUrl'];
    aboutContent = json['aboutContent'];
    appImg = json['appImg'];
    updUserId = json['updUserId'];
    updTime = json['updTime'];
    userToken = json['userToken'];
    customerServicePhone = json['customerServicePhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['appStoreId'] = this.appStoreId;
    data['appIosId'] = this.appIosId;
    data['appIosVersion'] = this.appIosVersion;
    data['appIosUpdFlag'] = this.appIosUpdFlag;
    data['appAndroidVersion'] = this.appAndroidVersion;
    data['appAndroidUpdFlag'] = this.appAndroidUpdFlag;
    data['androidDownloadUrl'] = this.androidDownloadUrl;
    data['userProtocolUrl'] = this.userProtocolUrl;
    data['dataServerUrl'] = this.dataServerUrl;
    data['resourceServerUrl'] = this.resourceServerUrl;
    data['webpageServerUrl'] = this.webpageServerUrl;
    data['splashImgUrl'] = this.splashImgUrl;
    data['aboutContent'] = this.aboutContent;
    data['appImg'] = this.appImg;
    data['updUserId'] = this.updUserId;
    data['updTime'] = this.updTime;
    data['userToken'] = this.userToken;
    data['customerServicePhone'] = this.customerServicePhone;
    return data;
  }
}

class SysInfoHelper {
  Database db;

  Future call(String path) async {
    db = await openDatabase(path);
  }

  Future insert(SysData sysData) async {
    await db.delete(TABLE_SYS_INFO, where: null, whereArgs: null);
    await db.insert(TABLE_SYS_INFO,
        <String, dynamic>{column_resourceServerUrl: sysData.resourceServerUrl});
  }

  Future<SysData> getSysInfo() async {
    List<Map> maps = await db.query(TABLE_SYS_INFO,
        columns: null, where: null, whereArgs: null);
    if (maps.length > 0) {
      return new SysData.fromJson(maps.first);
    }
    return null;
  }

  Future close() async => db.close();
}
