import 'package:flutter/cupertino.dart';

class TabClassify extends StatefulWidget {
  @override
  _TabClassifyState createState() => _TabClassifyState();
}

class _TabClassifyState extends State<TabClassify> {
  @override
  void initState() {
    super.initState();
    test();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text('tabClassify'));
  }
}

abstract class Base {
  a() {
//    print("base a()");
  }

  b() {
    print("base b()");
  }

  c() {
    print("base c()");
  }
}

class A extends Base {
  a() {
    print("A.a()");
    super.a();
  }

  b() {
    print("A.b()");
//    super.b();
  }
}

class A2 extends Base {
  a() {
    print("A2.a()");
    super.a();
  }
}

class B extends Base {
  a() {
    print("B.a()");
    super.a();
  }
}

class Test extends B with A, A2 {}

test() {
  var test = Test();
  test.a();
}
