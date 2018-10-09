import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wxm/constants.dart';
import 'package:wxm/utis.dart';

Widget getRefreshHeaderView({int mode}) {
  return new ClassicIndicator(
    mode: mode,
    textStyle: TextStyle(inherit: true, fontSize: COMMON_TEXT_SIZE),
    refreshingIcon: CupertinoActivityIndicator(),
    refreshingText: '正在刷新',
    releaseText: '放开刷新',
    spacing: 8.0,
    idleText: '下拉刷新',
    noDataText: '没有更多数据',
    failedText: '刷新失败',
    completeText: '刷新完成',
  );
}

Widget getLoadMoreFooterView({int mode}) {
  return new ClassicIndicator(
    mode: mode,
    textStyle: TextStyle(inherit: true, fontSize: COMMON_TEXT_SIZE),
    spacing: 8.0,
    refreshingIcon: CupertinoActivityIndicator(),
    refreshingText: '正在加载更多',
    releaseText: '放开加载更多',
    idleText: '上拉加载更多',
    noDataText: '没有更多数据',
    failedText: '加载失败',
    completeText: '加载完成',
  );
}

Config get myRefreshConfig => RefreshConfig(visibleRange: 60.0);

///列表空布局
Widget getEmptyView() {
  return new CustomScrollView(slivers: <Widget>[
    new SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      Container(
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: Text(
            "暂无数据",
            style: TextStyle(fontSize: COMMON_TEXT_SIZE),
          ),
        ),
      )
    ]))
  ]);
}
