import 'package:flutter/cupertino.dart';

class TabMine extends StatefulWidget {
  @override
  _TabMineState createState() => _TabMineState();
}

class Test {}

class _TabMineState extends State<TabMine> {
  @override
  void initState() {
    var test = Test();
    testType(test);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text('tabMine'));
  }
}

testType(dynamic test){
  print(test);
  print(test is Test);
}
