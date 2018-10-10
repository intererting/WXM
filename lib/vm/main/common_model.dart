import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wxm/main.dart';

class RouteModel {
  const RouteModel({
    @required this.category,
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(category != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final RouteCategory category;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($routeName)';
  }
}

class RouteCategory {
  final String category;

  const RouteCategory({this.category});
}

const String HTTP_SUCCESS = "0";
const String HTTP_FAILED = "1";

///网络返回信息
class HttpResult<T> {
  String resultCode;
  String resultMsg;
  String resultCount;
  T data;

  bool get httpSuccess => resultCode == HTTP_SUCCESS;

  HttpResult({this.resultCode, this.resultMsg, this.resultCount, this.data});

  HttpResult.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
    resultCount = json['resultCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    data['resultCount'] = this.resultCount;
    return data;
  }
}
