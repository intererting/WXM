import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:wxm/constants.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/view/banner.dart';
import 'package:wxm/view/refresh_view.dart';
import 'package:wxm/vm/home/tab_home_model.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with WidgetsBindingObserver {
  RefreshController _refreshController;
  AppLifecycleState _lifecycleState;
  AdInfo _adInfo;
  List<String> _titles;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshController = RefreshController();
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
          headerConfig: myRefreshConfig,
          headerBuilder: (BuildContext context, int mode) =>
              getRefreshHeaderView(mode: mode),
          footerBuilder: (BuildContext context, int mode) =>
              getLoadMoreFooterView(mode: mode),
          child: _buildContent()),
    );
  }

  ///加载数据
  void _refreshData(bool up) async {
    if (up) {
      print('_refreshData');
      String dataURL = '${WebConstant.RESTFUL_SERVICE_HOST_WWW}getAdList';
      http.Response response = await http.post(dataURL);
      AdInfo adInfo = AdInfo.fromJson(json.decode(response.body));
      //格式化图片地址
      List<String> titles = new List<String>();
      for (AdData adData in adInfo.data) {
        titles.add(adData.adInfo);
        adData.imgUrl = await formatUrl(adData.imgUrl);
      }
      //初始化标题
      setState(() {
        this._adInfo = adInfo;
        this._titles = titles;
      });
    }
  }

  Widget _buildContent() {
    if (_adInfo == null) {
      return getEmptyView();
    } else {
      print('_lifecycleState  $_lifecycleState');
      return new CustomScrollView(slivers: <Widget>[
        new SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          new BannerView(
              data: _adInfo.data,
              titles: _titles,
              buildShowView: (int index, dynamic itemData) =>
                  _buildAdView(index, itemData),
              width: screenWidth,
              height: 180.0)
        ]))
      ]);
    }
  }

  Widget _buildAdView(int index, AdData itemData) {
//    formatUrl(itemData.imgUrl).then((url) {
//      print(url);
//    });
    return Image.network(
      itemData.imgUrl,
      fit: BoxFit.fill,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lifecycleState = state;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
