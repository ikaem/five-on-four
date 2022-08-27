import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/material.dart';

// todo MIGHt not be needed
// OR, use a bit of change possibly to reuse this in the aon generate route somewhoe
extension NavigationExtension on BuildContext {
  T? getRouteArgument<T>() {
    // THIS IS THE BUILD CONTEXT IN THIS CASE
    final route = ModalRoute.of(this);
    if (route == null) return null;

    final args = route.settings.arguments;

    if (args == null) return null;
    if (args is! T) return null;

// her e we know args is T
    return args as T;
  }
}
