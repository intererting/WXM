import 'package:flutter/material.dart';
import 'package:wxm/constant.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/vm/home/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGuidePage extends StatefulWidget {
  static const routeName = "/guide";

  @override
  _UserGuidePageState createState() => _UserGuidePageState();
}

class _UserGuidePageState extends State<UserGuidePage> {
  var imageDatas = <String>[
    'images/user_guide_1.png',
    'images/user_guide_2.png',
    'images/user_guide_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: imageDatas.length,
          itemBuilder: (BuildContext context, int index) =>
              _buildItemView(context, index)),
    );
  }

  Widget _buildItemView(BuildContext context, int index) {
    return Stack(
      children: <Widget>[
        Image(
          width: screenWidth,
          height: screenHeight,
          image: AssetImage(imageDatas[index]),
          fit: BoxFit.fill,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 50.0),
          alignment: Alignment.bottomCenter,
          child: _buildIndicator(context, index),
        )
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, int index) {
    if (index == imageDatas.length - 1) {
      //最后一个
      return DecoratedBox(
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0, bottom: 8.0),
          child: GestureDetector(
            child: Text(
              '点击进入',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            onTap: () {
              _startHomePage();
            },
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),

//          decoration: ShapeDecoration(
//              shape: RoundedRectangleBorder(
//                side: BorderSide(width: 1.0, color: Colors.blue),
//                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//              ))
      );
    }
    final indicators = <Widget>[];
    for (int i = 0; i < imageDatas.length; i++) {
      final dot = Container(
        margin: EdgeInsets.all(5.0),
        width: 8.0,
        height: 8.0,
        child: CircleAvatar(
          backgroundColor: i == index ? Colors.blue : Colors.grey,
        ),
      );
      indicators.add(dot);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  _startHomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SP_PASS_GUIDE, true);
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }
}
