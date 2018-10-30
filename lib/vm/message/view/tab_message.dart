import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wxm/main.dart';
import 'package:wxm/src/redux/redux_state.dart';
import 'package:wxm/vm/main/common_model.dart';

class TabMessage extends StatefulWidget {
  @override
  _TabMessageState createState() => _TabMessageState();
}

class _TabMessageState extends State<TabMessage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            new StoreConnector<ReduxState, Widget>(converter: (store) {
              return GestureDetector(
                child: new Text(
                  store.state.loginInfo.userName,
                  style: Theme.of(context).textTheme.display1,
                ),
                onTap: () {
                  store.dispatch(new UpdateLoginInfoAction(LoginInfo("xxxxx")));
                },
              );
            }, builder: (context, widget) {
              return widget;
//                  return GestureDetector(
//                    child: new Text(
//                      loginInfo.userName,
//                      style: Theme
//                          .of(context)
//                          .textTheme
//                          .display1,
//                    ),
//                    onTap: store.dispatch(
//                        new UpdateLoginInfoAction(LoginInfo("after update")));,
//                  );
            }),
            new StoreConnector<ReduxState, bool>(
                converter: (store) => store.state.first,
                builder: (context, first) {
                  return new Text(
                    first ? 'true' : 'false',
                    style: Theme.of(context).textTheme.display1,
                  );
                }),
          ],
        ),
        floatingActionButton: new StoreConnector<ReduxState, VoidCallback>(
          converter: (store) {
            // Return a `VoidCallback`, which is a fancy name for a function
            // with no parameters. It only dispatches an Increment action.
            return () {
              store.dispatch(
                  new UpdateLoginInfoAction(LoginInfo("after update")));
            };
          },
          builder: (context, callback) {
            return new FloatingActionButton(
              // Attach the `callback` to the `onPressed` attribute
              onPressed: callback,
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
