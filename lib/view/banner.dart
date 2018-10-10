import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wxm/constants.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);
typedef void OnBannerPosition(int position);

const IntegerMax = 0x7fffffff;

class BannerView extends StatefulWidget {
  final double width;
  final double height;
  final double viewportFraction;
  final List data;
  final List<String> titles;
  final OnBannerClickListener onBannerClickListener;
  final BuildShowView buildShowView;
  final OnBannerPosition bannerPosition;
  final PageController pageController;

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
    this.titles,
    this.pageController,
    this.bannerPosition,
    this.onBannerClickListener,
    this.delayTime = 3000,
    this.scrollTime = 400,
    this.viewportFraction = 1.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
  PageController _pageController;
  Timer timer;
  int currentPoi = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController == null
        ? PageController(
            initialPage: IntegerMax ~/ 2 - IntegerMax ~/ 2 % widget.data.length,
            viewportFraction: widget.viewportFraction)
        : widget.pageController;
    resetTimer();
  }

  resetTimer() {
    clearTimer();
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

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  ///banner指示器
  List<Widget> _buildBannerIndicator() {
    if (widget.titles != null && widget.titles.isNotEmpty) {
      final indicators = <Widget>[];
      for (int i = 0; i < widget.titles.length; i++) {
        final dot = Container(
          margin: EdgeInsets.only(left: 5.0),
          width: 8.0,
          height: 8.0,
          child: CircleAvatar(
            backgroundColor: this.currentPoi % widget.titles.length == i
                ? Colors.black
                : Colors.grey,
          ),
        );
        indicators.add(dot);
      }
      return indicators;
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
                  clearTimer();
                },
                onTapUp: (details) {
                  resetTimer();
                },
                onTapCancel: () {
                  resetTimer();
                },
                child: new Stack(
                  children: <Widget>[
                    new PageView.builder(
                      controller: _pageController,
                      physics: const PageScrollPhysics(
                          parent: const ScrollPhysics()),
                      itemBuilder: (BuildContext context, int index) {
                        return widget.buildShowView(
                            index, widget.data[index % widget.data.length]);
                      },
                      itemCount: IntegerMax,
                      onPageChanged: (int position) {
                        if (widget.bannerPosition != null) {
                          widget.bannerPosition(position);
                          setState(() {
                            this.currentPoi = position;
                          });
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Color(0x33333333),
                        padding: EdgeInsets.symmetric(
                            horizontal: SCREEN_MARGIN, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: _buildBannerIndicator(),
                            ),
                            Text(
                              widget.titles[currentPoi % widget.titles.length],
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
