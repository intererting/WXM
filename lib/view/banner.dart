import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener<M>(int index, M itemData);
typedef Widget BuildShowView<M>(int index, M itemData);
typedef void OnBannerPosition(int position);

const IntegerMax = 0x7fffffff;

class BannerView<M> extends StatefulWidget {
  final double width;
  final double height;
  final double viewportFraction;
  final List<M> data;
  final OnBannerClickListener<M> onBannerClickListener;
  final BuildShowView<M> buildShowView;
  final OnBannerPosition bannerPosition;

  //延迟多少秒进入下一页
  final int delayTime;

  //滑动需要秒数
  final int scrollTime;

  BannerView({
    Key key,
    @required this.data,
    @required this.buildShowView,
    @required this.width,
    @required this.height,
    this.bannerPosition,
    this.onBannerClickListener,
    this.delayTime = 3000,
    this.scrollTime = 800,
    this.viewportFraction = 1.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
  PageController _pageController;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: IntegerMax ~/ 2 - IntegerMax ~/ 2 % widget.data.length,
        viewportFraction: widget.viewportFraction);
    _resetTimer();
  }

  _resetTimer() {
    _clearTimer();
    timer = new Timer.periodic(new Duration(milliseconds: widget.delayTime),
        (Timer timer) {
      if (_pageController.positions.isNotEmpty) {
        var i = _pageController.page.toInt() + 1;
        _pageController.animateToPage(i,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.linear);
      }
    });
  }

  _clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.data.length == 0
            ? null
            : new GestureDetector(
                onTap: () {
                  if (widget.onBannerClickListener != null) {
                    widget.onBannerClickListener(
                        _pageController.page.round() % widget.data.length,
                        widget.data[
                            _pageController.page.round() % widget.data.length]);
                  }
                },
                onTapDown: (details) {
                  _clearTimer();
                },
                onTapUp: (details) {
                  _resetTimer();
                },
                onTapCancel: () {
                  _resetTimer();
                },
                child: new PageView.builder(
                  controller: _pageController,
                  physics:
                      const PageScrollPhysics(parent: const ScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    return widget.buildShowView(
                        index, widget.data[index % widget.data.length]);
                  },
                  itemCount: IntegerMax,
                  onPageChanged: (int position) {
                    if (widget.bannerPosition != null) {
                      widget.bannerPosition(position);
                    }
                  },
                ),
              ));
  }

  @override
  void dispose() {
    _clearTimer();
    super.dispose();
  }
}
