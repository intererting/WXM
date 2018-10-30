import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/src/redux/redux_state.dart';
import 'package:wxm/view/wxm_theme.dart';
import 'package:wxm/vm/main/common_model.dart';
import 'package:wxm/vm/main/page_home.dart';
import 'package:wxm/vm/main/page_splash.dart';
import 'package:wxm/vm/main/page_user_guide.dart';
import 'package:flutter/cupertino.dart';

void main() => runZoned(() {
      runApp(new MyApp());
    }, onError: (dynamic error, dynamic stack) {
      print('MyAppError $error');
      print(stack);
    });

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class UpdateLoginInfoAction {
//  static UpdateLoginInfoAction updateLoginInfoAction;

//  factory UpdateLoginInfoAction(LoginInfo loginInfo) {
//    if (updateLoginInfoAction == null) {
//      updateLoginInfoAction = UpdateLoginInfoAction._internal(loginInfo);
//    }
//    return updateLoginInfoAction;
//  }

//  UpdateLoginInfoAction._internal(this.loginInfo);

  final LoginInfo loginInfo;

  UpdateLoginInfoAction(this.loginInfo);
}

class UpdateFirstAction {
  bool first;

  UpdateFirstAction(this.first);

//  static UpdateFirstAction updateFirstAction;

//  factory UpdateFirstAction(bool first) {
//    if (updateFirstAction == null) {
//      updateFirstAction = UpdateFirstAction._internal(first);
//    }
//    return updateFirstAction;
//  }

//  UpdateFirstAction._internal(this.first);

//  @override
//  int get hashCode => first.hashCode;
//
//  @override
//  bool operator ==(other) {
//    if (identical(this, other)) {
//      return true;
//    }
//    if (other.runtimeType != runtimeType) return false;
//    return first == other.first;
//  }
}

ReduxState appReducer(ReduxState state, dynamic action) {
  print(action.runtimeType is UpdateLoginInfoAction);

//  var loginReducer =
//      TypedReducer<LoginInfo, UpdateLoginInfoAction>(_loginReducer);
//  var firstReducer = TypedReducer<bool, UpdateFirstAction>(_firstReducer);
  return new ReduxState(
      loginInfo: _loginReducer(state.loginInfo, action),
      first: _firstReducer(state.first, action));
}

//final loginReducers = combineReducers<LoginInfo>([
//  new TypedReducer<LoginInfo, UpdateLoginInfoAction>(_loginReducer),
//]);

LoginInfo _loginReducer(LoginInfo loginInfo, dynamic action) {
  if (action is UpdateLoginInfoAction) {
    print('_loginReducer  loginInfo${loginInfo.userName}');
    print('_loginReducer action  ${action.loginInfo.userName}');
    return action.loginInfo;
  }
  return loginInfo;
}

//final firstReducers = combineReducers<bool>([
//  new TypedReducer<bool, UpdateFirstAction>(_firstReducer),
//]);

bool _firstReducer(bool first, dynamic action) {
//  return action.first;
  return false;
}

class _MyAppState extends State<MyApp> {
  Store<ReduxState> store;

  @override
  void initState() {
    super.initState();

    store = new Store<ReduxState>(appReducer,
        initialState: new ReduxState(
            loginInfo: new LoginInfo('initLoginInfo'), first: true));
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReduxState>(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
//      builder: (BuildContext context, Widget child) {
//        return WxmTheme(
//          child: child,
//        );
//      },
        theme: ThemeData(primaryColor: Colors.white),
        routes: <String, WidgetBuilder>{
          '/': (context) => SplashPage(),
          HomePage.routeName: (context) => HomePage(),
          UserGuidePage.routeName: (context) => UserGuidePage(),
        },
      ),
    );
  }
}
