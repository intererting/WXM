import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:wxm/ConstantHelper.dart';
import 'package:wxm/common_model.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/http_client.dart';
import 'package:wxm/utis.dart';
import 'package:wxm/view/banner.dart';
import 'package:wxm/view/refresh_view.dart';
import 'package:wxm/vm/home/model/ad_model.dart';
import 'package:wxm/vm/home/model/commodity_model.dart';
import 'package:wxm/vm/home/page_wsjt.dart';

///首页
class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with WidgetsBindingObserver {
  RefreshController _refreshController = RefreshController();
  GlobalKey<BannerViewState> bannerViewKey = new GlobalKey();
  final CancelToken _cancelToken = new CancelToken();
  PageInfo pageInfo = new PageInfo();
  List<CommodityData> _commodityDatas = new List();
  List<String> _titles = new List();

//  ConstantHelper constantHelper = new ConstantHelper();
  AdInfo _adInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshData(true);
  }

  @override
  Widget build(BuildContext context) {
//   final WxmTheme wxmTheme=WxmTheme.of(context);
//    print('wxmTheme  ${wxmTheme.serverResourceUrl}');
    return DefaultTextStyle(
      style: TextStyle(
          fontSize: COMMON_TEXT_SIZE, color: WxmColors.commonBlackColor),
      child: CupertinoPageScaffold(
        backgroundColor: WxmColors.bgColor,
        child: SmartRefresher(
            enablePullUp: !isListNullOrEmpty(_commodityDatas) &&
                _commodityDatas.length % pageInfo.PER_PAGE == 0,
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
      ),
    );
  }

  ///加载数据
  void _refreshData(bool up) async {
    if (up) {
      print('_refreshData');
      _getAdInfo();
      _getCommodityList();
    }
  }

  Widget _buildContent() {
    if (_adInfo == null && isListNullOrEmpty(_commodityDatas)) {
      return getEmptyView();
    } else {
      return new CustomScrollView(slivers: <Widget>[
        new SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          _initBannerView(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(SCREEN_MARGIN),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: _buildTopCardView(
                      bgColor: Colors.amber,
                      title: '万寿讲堂',
                      subTitle: '名家讲堂，传授长寿秘籍',
                      imageRes: 'images/wsjt.png'),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(new CupertinoPageRoute(builder: (BuildContext _) {
                      return WsjtPage();
                    }));
                  },
                ),
                _buildTopCardView(
                    bgColor: Colors.purpleAccent,
                    title: '万寿秘籍',
                    subTitle: '数百种养身急救方法',
                    imageRes: 'images/wsmj.png')
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(SCREEN_MARGIN),
            margin: EdgeInsets.only(top: SCREEN_MARGIN),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('images/wsjt.png'),
                    Text('康答要闻')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset("images/wsjt.png"),
                    Text('康答要闻')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/wsjt.png'),
                    Text('康答要闻')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/wsjt.png'),
                    Text('康答要闻')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/wsjt.png'),
                    Text('康答要闻')
                  ],
                )
              ],
            ),
          ),
          new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: SCREEN_MARGIN),
            child: Text(
              '今日推荐',
              style: TextStyle(color: Colors.blue, fontSize: COMMON_TEXT_SIZE),
            ),
          )
        ])),
        _initCommodityView(),
      ]);
    }
  }

  Widget _buildAdView(int index, AdData itemData) {
//    WxmTheme wxmTheme = WxmTheme.of(context);
    return Transform.scale(
      scale: 0.5,
      child: Image.network(
        itemData.imgUrl,
        fit: BoxFit.fill,
      ),
    );
  }

  ///顶部卡片导航
  Widget _buildTopCardView(
      {String title, String subTitle, String imageRes, Color bgColor}) {
    return Container(
      width: (screenWidth - SCREEN_MARGIN * 3) / 2,
      height: 100.0,
      child: new Card(
        margin: EdgeInsets.all(0.0),
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              margin: EdgeInsets.only(top: SCREEN_MARGIN),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: Colors.black87),
            ),
            new Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Image.asset(imageRes),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('inactive');
        break;
      case AppLifecycleState.paused:
        debugPrint('paused');
        bannerViewKey.currentState.clearTimer();
        break;
      case AppLifecycleState.resumed:
        debugPrint('resumed');
        bannerViewKey.currentState.resetTimer();
        break;
      case AppLifecycleState.suspending:
        break;
    }
  }

  ///列表Item
  Widget _buildGridItemView(BuildContext context, int index) {
    CommodityData commodityData = _commodityDatas[index];
//    WxmTheme wxmTheme = WxmTheme.of(context);
    return Container(
      margin: EdgeInsets.only(
          left: index % 2 == 0 ? SCREEN_MARGIN : 0.0,
          right: index % 2 != 0 ? SCREEN_MARGIN : 0.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image.network(
              commodityData.commodityLogoUrl,
              width: screenWidth - SCREEN_MARGIN * 3,
              height: 100.0,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              alignment: Alignment.topLeft,
              child: Text(
                commodityData.commodityName,
                maxLines: 2,
                style: TextStyle(
                    fontSize: COMMON_TEXT_SIZE, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              alignment: Alignment.topLeft,
              child: Text(
                '￥${commodityData.feeNow}',
                style: TextStyle(color: Colors.red, fontSize: COMMON_TEXT_SIZE),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              alignment: Alignment.topLeft,
              child: Text(
                '￥${commodityData.feeOld}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                    decoration: TextDecoration.lineThrough),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  ///广告信息
  void _getAdInfo() {
    try {
      WxmHttpClient()
          .dio
          .post('getAdList', cancelToken: _cancelToken)
          .then((Response response) async {
        if (isSuccessResponse(response)) {
          AdInfo adInfo = AdInfo.fromJson(response.data);
          List<String> titles = new List();
//          adInfo.data.forEach((AdData adData) async {
//            print('xxxxxxxxxxxxxxxxxxxx');
//            titles.add(adData.adInfo);
//            adData.imgUrl = await formatUrl(adData.imgUrl);
//          });

//          Stream.fromIterable(adInfo.data).listen((AdData adData) {
//            titles.add(adData.adInfo);
//            formatUrl(adData.imgUrl).then((url) {
//              adData.imgUrl = url;
//              print('xxxxxxxxxxxxxxxxxxxx');
//            });
//          }, onDone: () {
//            print('yyyyyyyyyyyyyyyyyyyyyyyyy');
//            setState(() {
//              this._adInfo = adInfo;
//              this._titles = titles;
//            });
//          });
//          Future.wait(
//              adInfo.data.map((AdData adData) => formatUrl(adData.imgUrl))).

          for (AdData adData in adInfo.data) {
            titles.add(adData.adInfo);
            adData.imgUrl = await formatUrl(adData.imgUrl);
          }
          setState(() {
            this._adInfo = adInfo;
            this._titles = titles;
          });
        }
      });

//      Response response = await WxmHttpClient()
//          .dio
//          .post('getAdList', cancelToken: _cancelToken);
    } catch (e) {}
  }

  ///首页商品信息
  void _getCommodityList() async {
    try {
      Response response = await WxmHttpClient().dio.post('getHomeCommodityList',
          data: {
            'userId': '1000000000',
            'lastTime': pageInfo.lastTime,
            'pageNum': pageInfo.pageNo
          },
          options: new Options(
              contentType:
                  ContentType.parse("application/x-www-form-urlencoded")),
          cancelToken: _cancelToken);
      if (isSuccessResponse(response)) {
        List<CommodityData> commodityDatas =
            CommodityInfo.fromJson(response.data).data;
        for (CommodityData commodityData in commodityDatas) {
          commodityData.commodityLogoUrl =
              await formatUrl(commodityData.commodityLogoUrl);
        }
        setState(() {
          _commodityDatas = commodityDatas;
        });
      }
    } catch (e) {} finally {
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
//    print(json.encode(response.data));
  }

  Widget _initBannerView() {
    if (_adInfo != null) {
      return new BannerView(
          key: bannerViewKey,
          data: _adInfo.data,
          titles: _titles,
          bannerPosition: (int position) {},
          buildShowView: (int index, dynamic itemData) =>
              _buildAdView(index, itemData),
          width: screenWidth,
          height: 180.0);
    }
  }

  Widget _initCommodityView() {
    return new SliverGrid(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.88,
          mainAxisSpacing: SCREEN_MARGIN,
          crossAxisSpacing: SCREEN_MARGIN),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) => _buildGridItemView(context, index),
        childCount:
            isListNullOrEmpty(_commodityDatas) ? 0 : _commodityDatas.length,
      ),
    );
  }
}
