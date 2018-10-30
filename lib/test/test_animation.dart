import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wxm/utis.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double startX = 0.0;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.value = 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Transform.translate(
          offset: new Offset(animation.value * screenWidth - 50, 0.0),
          child: GestureDetector(
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.red,
            ),
            onHorizontalDragUpdate: _onPanUpdate,
          ),
        ));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    startX += details.delta.dx;
    controller.value = startX / screenWidth;
  }

  void _onPanStart(DragUpdateDetails details) {
    startX = details.delta.dx;
  }
}
