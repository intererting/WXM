import 'package:flutter/material.dart';
import 'package:wxm/utis.dart';

void main() {
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  runApp(DialogTest());
}

class DialogTest extends StatefulWidget {
  @override
  _DialogTestState createState() => _DialogTestState();
}

class _DialogTestState extends State<DialogTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Image(
              fit: BoxFit.fill,
              image: AssetImage("images/splash.png"),
            ),
            Material(
              type: MaterialType.card,
              elevation: 24.0,
              color: Color(0x33000000),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Container(
                    color: Colors.white,
                    child: Text("弹出框"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
