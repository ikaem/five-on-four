import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/screens/home_screen.dart';
import 'package:five_on_four/screens/matches/match_edit_screen.dart';
import 'package:five_on_four/screens/matches/match_screen.dart';
import 'package:flutter/cupertino.dart';

// TODO but here i did define a type, not a function - so i could define a type for a map
// OK, SO THIS WORKS because we dont know what are exact names of fields in the map
typedef RoutesMap = Map<String, Widget Function(BuildContext)>;

class AppRouter {
  static RoutesMap generateRoutes(BuildContext context) {
    return {
      // TODO views should probably be called screens or some such
      Routes.homeRoute: (context) => HomeScreen(),
      Routes.matchEditRoute: (context) => MatchEditScreen(),
      Routes.matchViewRoute: (context) => MatchScreen(),
    };
  }

  static void toHome(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.homeRoute);
  }

  static void toMatch(BuildContext context, int matchId) {
    Navigator.of(context).pushNamed(Routes.matchViewRoute, arguments: matchId);
  }

  static void toMatchEdit(BuildContext context, String? matchId) {
    // here we could say that if match id is passed, this should be editroute, and if not, it is a create route
    Navigator.of(context).pushNamed(Routes.matchEditRoute);
  }
}
