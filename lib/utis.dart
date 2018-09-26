import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//状态栏的高度
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double get screenWidth => MediaQueryData.fromWindow(ui.window).size.width;

double get screenHeight => MediaQueryData.fromWindow(ui.window).size.height;