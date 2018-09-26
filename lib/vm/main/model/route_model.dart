import 'package:flutter/material.dart';
import 'package:wxm/main.dart';

class RouteModel {
  const RouteModel({
    @required this.category,
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(category != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final RouteCategory category;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($routeName)';
  }
}

class RouteCategory {
  final String category;

  const RouteCategory({this.category});
}
