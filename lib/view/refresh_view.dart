import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget getRefreshHeaderView({int mode}) {
  return new ClassicIndicator(
    mode: mode,
    height: 50.0,
    textStyle: TextStyle(inherit: true, fontSize: 15.0),
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
    textStyle: TextStyle(inherit: true, fontSize: 15.0),
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
