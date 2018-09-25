import 'package:flutter/material.dart';

//状态栏的高度
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
