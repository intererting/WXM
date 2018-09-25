import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wxm/constant.dart';
import 'package:wxm/test/test_file_path.dart';

void main() => runZoned(() {
      runApp(new MyApp());
    }, onError: (dynamic error, dynamic stack) {
      print('MyAppError $error');
      print(stack);
    });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: bgColor,
        primaryColor: Colors.white,
        platform: TargetPlatform.iOS,
      ),
      home: new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          brightness: Brightness.light,
          title: Text("测试"),
        ),
        body: FilePathTest(),
      ),
    );
  }
}
