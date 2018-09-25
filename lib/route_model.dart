import 'package:flutter/material.dart';

class RouteModel {
  const RouteModel({
    @required this.category,
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(category != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String category;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($routeName)';
  }
}
