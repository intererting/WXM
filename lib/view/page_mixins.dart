import 'package:flutter/cupertino.dart';

enum PageAnimationType { SLIDE, FADE }

const animationDuration = 200;

class PageMixins {
  void startPageWithAnimation({
    @required BuildContext mContext,
    @required Widget targetView,
    PageAnimationType animationType = PageAnimationType.SLIDE,
    bool popBefore = false,
  }) {
    if (animationType == PageAnimationType.FADE) {
      if (popBefore) {
        Navigator.pushReplacement(
            mContext,
            new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
                  return targetView;
                },
                transitionDuration: Duration(milliseconds: animationDuration),
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return new FadeTransition(
                    child: child,
                    opacity: new Tween<double>(begin: 0.3, end: 1.0)
                        .animate(animation),
                  );
                }));
      } else {
        Navigator.push(
            mContext,
            new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
                  return targetView;
                },
                transitionDuration: Duration(milliseconds: animationDuration),
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return new FadeTransition(
                    child: child,
                    opacity: new Tween<double>(begin: 0.3, end: 1.0)
                        .animate(animation),
                  );
                }));
      }
    } else if (animationType == PageAnimationType.SLIDE) {
      if (popBefore) {
        Navigator.pushReplacement(
            mContext,
            new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
                  return targetView;
                },
                transitionDuration: Duration(milliseconds: animationDuration),
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return new SlideTransition(
                    position: new Tween<Offset>(
                            begin: Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );
                }));
      } else {
        Navigator.push(
            mContext,
            new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
                  return targetView;
                },
                transitionDuration: Duration(milliseconds: animationDuration),
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return new SlideTransition(
                    position: new Tween<Offset>(
                            begin: Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );
                }));
      }
    }
  }
}
