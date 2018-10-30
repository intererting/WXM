import 'package:flutter/material.dart';

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
        body: Builder(builder: (BuildContext context) {
          return RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog());
            },
            child: Text("showDiglog"),
          );
        }),
      ),
    );
  }
}

//showDialog
//(
//context: context,builder: (
//
//BuildContext context
//)
//{
//return Text("xxxxxxxxxxxxxxxxxxxxxx");
//}
//);
