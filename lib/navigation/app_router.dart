import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/views/home_view.dart';
import 'package:five_on_four/views/matches/match_edit_view.dart';
import 'package:five_on_four/views/matches/match_view.dart';
import 'package:flutter/cupertino.dart';

typedef RoutesMap = Map<String, Widget Function(BuildContext)>;

class AppRouter {
  static RoutesMap generateRoutes(BuildContext context) {
    return {
      // TODO views should probably be called screens or some such
      Routes.homeRoute: (context) => HomeView(),
      Routes.matchEditRoute: (context) => MatchEditView(),
      Routes.matchViewRoute: (context) => MatchView(),
    };
  }

  static void toHome(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.homeRoute);
  }

  static void toMatch(BuildContext context, String matchId) {
    Navigator.of(context).pushNamed(Routes.matchViewRoute);
  }

  static void toMatchEdit(BuildContext context, String matchId) {
    // here we could say that if match id is passed, this should be editroute, and if not, it is a create route
    Navigator.of(context).pushNamed(Routes.matchEditRoute);
  }
}
