import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/main.dart';
import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/screens/auth/login.dart';
import 'package:five_on_four/screens/home_screen.dart';
import 'package:five_on_four/screens/matches/match_edit_screen.dart';
import 'package:five_on_four/screens/matches/match_screen.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO but here i did define a type, not a function - so i could define a type for a map
// OK, SO THIS WORKS because we dont know what are exact names of fields in the map
typedef RoutesMap = Map<String, Widget Function(BuildContext)>;

class AppRouter {
  static final _privateRoutes = {
    // Routes.homeRoute: (context) => HomeScreen(),
    // Routes.rootRoute: (BuildContext context) => RootRoute(),
    Routes.homeRoute: (BuildContext context) => HomeScreen(),
    Routes.matchEditRoute: (BuildContext context) => MatchEditScreen(),
    Routes.matchViewRoute: (BuildContext context) => MatchScreen(),
    Routes.loginRoute: (context) => LoginScreen(),
  };

  static final _publicRoutes = {
    // Routes.rootRoute: (BuildContext context) => RootRoute(),
  };

// TODO old
  static RoutesMap generateRoutes(BuildContext context, Auth? auth) {
    // if (auth == null) return _publicRoutes;

    return _privateRoutes;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // HERE we could define in auth is true, but it might not be needed, because intiial route might handle that
    // but later, if we have more protzected ones, we can handle it by cchecking if auth is valid

    devService.log("this is in generate route: ${settings.name}");

    switch (settings.name) {
      case Routes.loginRoute:
        // return MaterialPageRoute(builder: (_) => HomeScreen());
        return MaterialPageRoute(builder: _privateRoutes[Routes.loginRoute]!);

      case Routes.homeRoute:
        // return MaterialPageRoute(builder: (_) => HomeScreen());
        return MaterialPageRoute(builder: _privateRoutes[Routes.homeRoute]!);

      case Routes.matchEditRoute:
        // return MaterialPageRoute(builder: (_) => HomeScreen());
        return MaterialPageRoute(
            builder: _privateRoutes[Routes.matchEditRoute]!);
      case Routes.matchViewRoute:
        // return MaterialPageRoute(builder: (_) => HomeScreen());
        return MaterialPageRoute(
            builder: _privateRoutes[Routes.matchViewRoute]!);

      // TODO switch to handle arguments from here, too

      /* 
        case RoutePaths.SecondScreen:
        // you can do things like pass arguments to screens
        final event = settings.arguments as Event;
        return MaterialPageRoute(
            builder: (_) => YourSecondScreenWidget(event: event));
        
         */

      default:
        return MaterialPageRoute(
          builder: ((context) => Scaffold(
                body: Container(
                  child: Center(
                    child: Text("We don't know where we are..."),
                  ),
                ),
              )),
        );
    }
  }

  static String generateInitialRoute(BuildContext context, Auth? auth) {
    if (auth == null) return Routes.loginRoute;

    return Routes.homeRoute;

    // return {
    //   // TODO views should probably be called screens or some such
    //   Routes.homeRoute: (context) => HomeScreen(),
    //   Routes.matchEditRoute: (context) => MatchEditScreen(),
    //   Routes.matchViewRoute: (context) => MatchScreen(),
    //   // TODO test
    //   Routes.loginRoute: (context) => LoginScreen(),
    // };
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
