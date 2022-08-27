import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  T? getRouteArgument<T>() {
    // THIS IS THE BUILD CONTEXT IN THIS CASE
    final route = ModalRoute.of(this);
    if (route == null) return null;

    final args = route.settings.arguments;

    devService.log("args here: $args");
    if (args == null) return null;
    if (args is! T) return null;

// her e we know args is T
    return args as T;
  }
}
