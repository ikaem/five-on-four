import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:five_on_four/features/authentication/presentation/providers/auth_provider.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/screens/auth/login.dart';
import 'package:five_on_four/screens/home_screen.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  // TODO what does this do exactly
  WidgetsFlutterBinding.ensureInitialized();
  // TODO we could initialize db with bloc as well
  // https://stackoverflow.com/a/55673276

// there is another solution here, to say that it should be intiialized in a widget
// https://stackoverflow.com/questions/55671692/how-do-i-setup-a-database-when-flutter-app-launches
// TODO if keep this, this should jave a controller of its own i guess, not access it directly
  await Db().initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Auth? userAuth;

  final MatchesController _matchesController = MatchesController();
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _matchesController.loadMatches();

    _authController.authStream.listen((event) {
      if (event != userAuth) {
        setState(() {
          userAuth = event;
        });
      }
    });
  }

// TODO do we need to close the stream controller somehow
  @override
  void dispose() async {
    // TZODO not sure if this should be async
    await _authController.closeStreamController();
    super.dispose();
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return AppRouter.generateRoute(settings);
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    devService.log(
        "LOGGING INITIAL ROUTE IN ON GENERATE INITIAL ROUTE: $initialRoute");

    if (initialRoute == Routes.homeRoute) {
      return [MaterialPageRoute(builder: (context) => HomeScreen())];
    }

    return [MaterialPageRoute(builder: (context) => LoginScreen())];
  }

  Widget getHomePage() {
    if (userAuth == null) return LoginScreen();

    return HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    String initialRoute =
        userAuth == null ? Routes.loginRoute : Routes.homeRoute;

    devService.log("THIS IS INITIAL ROUTE: $initialRoute");

    return AuthStateInherited(
      auth: userAuth,
      child: MaterialApp(
        title: "Five On Four",
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en', 'US')], //, Locale('pt', 'BR')],
        onGenerateRoute: onGenerateRoute,

        home: getHomePage(),
        // TODO figure out how these actually work
        // initialRoute: initialRoute,
        // onGenerateInitialRoutes: onGenerateInitialRoutes,
      ),
    );
  }
}
