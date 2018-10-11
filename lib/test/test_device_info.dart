import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:device_info/device_info.dart';

class TestDeviceInfo extends StatefulWidget {
  @override
  _TestDeviceInfoState createState() => _TestDeviceInfoState();
}

class _TestDeviceInfoState extends State<TestDeviceInfo> {
  DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
  String sdkInfo;

  @override
  void initState() {
    super.initState();
    _testDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Text(sdkInfo ?? '');
  }

  Future<Null> _testDeviceInfo() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      sdkInfo = androidInfo.version.sdkInt.toString();
    });
  }
}
