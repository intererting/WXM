import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch:Colors.blue,
          brightness: Brightness.light,
          platform: TargetPlatform.android,
          iconTheme: IconThemeData(color: Colors.blue),
          accentColorBrightness: Brightness.light,
          primaryColorBrightness: Brightness.light),
      home: new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("测试"),
        ),
        body: new Text("hahaha"),
      ),
    );
  }
}
