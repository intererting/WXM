import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:wxm/constants.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/view/refresh_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  RefreshController _refreshController;
  dynamic adResult;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    //加载数据
    _refreshData(true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SmartRefresher(
          onRefresh: (up) {
            _refreshData(up);
          },
          controller: _refreshController,
          headerConfig: RefreshConfig(),
          headerBuilder: (BuildContext context, int mode) =>
              getRefreshHeaderView(mode: mode),
          footerBuilder: (BuildContext context, int mode) =>
              getLoadMoreFooterView(mode: mode),
          child: _buildContent()),
    );
  }

  ///加载数据
  void _refreshData(bool up) async {
    print('_refreshData');
    if (up) {
      String dataURL = '${WebConstant.RESTFUL_SERVICE_HOST_WWW}getAdList';
      http.Response response = await http.post(dataURL);
      setState(() {
        adResult = json.decode(response.body);
      });
    }
  }

  Widget _buildContent() {
    if (adResult == null) {
      return new CustomScrollView(slivers: <Widget>[
        new SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          Container(
            width: screenWidth,
            height: screenHeight,
            child: Text("xxxx"),
          )
        ]))
      ]);
    } else {
      print('${adResult['data'][0]['adId']}');
      return new CustomScrollView(slivers: <Widget>[
        new SliverList(delegate: SliverChildListDelegate(<Widget>[Text('xxx')]))
      ]);
    }
  }
}
