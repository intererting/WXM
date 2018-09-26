import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class BaseState<M extends StatefulWidget> extends State<M> {
  DeviceInfoPlugin _deviceInfo = new DeviceInfoPlugin();
  AndroidDeviceInfo _androidInfo;

  @override
  void initState() {
    super.initState();
//    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_androidInfo.brand);
  }

  Future<Null> _getDeviceInfo() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    setState(() {
      print('androidInfo');
      _androidInfo = androidInfo;
    });
  }
}
