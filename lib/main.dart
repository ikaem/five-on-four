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
  // TODO test
  // TODO what does this do exactly
  // do we need to run it?
  WidgetsFlutterBinding.ensureInitialized();
  // TODO we could initialize db with bloc as well
  // https://stackoverflow.com/a/55673276

// TODO not really sure if this is coreect way
// - using instance here
// - intiializing like this without any controller or such
// - maybe i could make a controller for general services
// there is another solution here, to say that it should be intiialized in a widget
// https://stackoverflow.com/questions/55671692/how-do-i-setup-a-database-when-flutter-app-launches
// TODO if keep this, this should jave a controller of its own i guess, not access it directly
  await Db().initialize();
  // final authController = AuthController();
  // await authController.checkSession();

//   await _authController.checkSession();

  // final auth = await _authController.auth;
//   // TODO what if this throws error to say that db is already open - just catch it?

// // TODO could probably check if we are logged in here as well
// // so here we can wrap auth provider inherted wiget around my app

//   // devService
//   //     .log("this is in main function auth: ${_authController.auth}");
//   devService.log("this is in main function auth: $auth");
  // runApp(AuthStateInherited(
  //   auth: auth,
  //   child: MyApp(),
  // ));

// TODO reqally not sure if this is ok
  // _authController.authStream.listen((event) {
  //   devService.log("printing events: $event");
  //   // setState(() {
  //   //   userAuth = event;
  //   // });

  //   runApp(AuthStateInherited(
  //     auth: event,
  //     child: MyApp(),
  //   ));
  // });

  runApp(MyApp());
}

// TODO this might not be needed to be stsateful
// i only put it as stteful to test why id does not update on auth stsate inherited state chagne
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TODO auth state could also be taken from the auth controlelr, too // if that update works at all to notify other sutff
  Auth? userAuth;
  String initialRoute = Routes.loginRoute;

// TODO this should probably make it ll stateful widget
  final MatchesController _matchesController = MatchesController();
  final AuthController _authController = AuthController();

  // String initialRoute = userAuth == null ? Routes.loginRoute : Routes.homeRoute;

  @override
  void initState() {
    super.initState();
    _matchesController.loadMatches();

    // _authController.currentAuth.then((auth) {
    //   devService.log("current auth: $auth");
    //   userAuth = auth;
    //   setState(() {});
    // });

// TODO this controller should probably be disposed somehow too
    _authController.authStream.listen((event) {
      devService.log("printing events !!!!!!!!!!!!!!!!!!!!!!: ${event?.user}");
      // devService.log("prev state in init state: !!!!!!!!!!!!!!: $userAuth");

      if (event != userAuth) {
        setState(() {
          userAuth = event;
        });
      }

// TODO this has no efffect
      //   initialRoute = event == null ? Routes.loginRoute : Routes.homeRoute;
      // setState(() {
      //   userAuth = event;
      //   initialRoute = event == null ? Routes.loginRoute : Routes.homeRoute;
      // });

      // devService.log("post state in init state: !!!!!!!!!!!!!!: $userAuth");
    });

    // TODO this does not trigger when we load the thing first
    // _authController.checkSession();
    // _authController.auth
    // _authController.checkSession().then((sessionAuth) {
    //   // setState(() {

    //   // });
    //   // TODO test
    //   // maybe here we can take the session, set state here, in this widget, and pass it on? or not? then update would not work?
    // });
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
    devService
        .log("this is intiial route in initial rotue generater: $initialRoute");

    devService.log("this is intiial user auth status: ${userAuth?.user}");

    if (initialRoute == Routes.homeRoute) {
      return [MaterialPageRoute(builder: (context) => HomeScreen())];
    }

    return [MaterialPageRoute(builder: (context) => LoginScreen())];
  }

  Widget getHomePage() {
    if (userAuth == null) return LoginScreen();

    return HomeScreen();
  }

  // TODO test
  Future<void> testPrintAuthFromStream() async {
    try {
      devService
          .log("this is AUTH IN TEST PRINT: ${_authController.currentAuth}");
      final auth = await _authController.currentAuth;
    } catch (e) {
      devService.log("some error: $e");
    }
    // devService.log("this is AUTH IN TEST PRINT: $auth");
  }

  // here we initialize auth controller
  @override
  Widget build(BuildContext context) {
    testPrintAuthFromStream();
    // _authController.checkSession();
// TODO this should probably live in some init state or something

// TODO this should be done in some init state, so this widget might need to be stateful
    // _authController.checkSession(context);

    // final auth = _authController.authState(context);
    // final auth = AuthStateInherited.of(context)?.auth;

    // devService.log("this is auth: ${auth}");

    // here we get auth value from the auth controller
    // and then we can either generate protected or unprotected routes, or private or public routes

    // Auth? testAuth = _authController.auth;
    // final initialRoute =
    //     testAuth == null ? Routes.loginRoute : Routes.homeRoute;

    // final initialRoute = AppRouter.generateInitialRoute(context, userAuth);
    // final routes = AppRouter.generateRoutes(context, userAuth);
    // final onGenerateRoute = AppRouter.generateRoute;

    // devService.log("test auth: $userAuth");
    // devService.log("initial route in main: $initialRoute");
    // devService.log("routes in main: $routes");

    // TODO maybe i am not passing data to auth provider at all

    // final authState = _authController.authState(context);

    // final Home = userAuth == null ? LoginScreen() : HomeScreen();

    devService.log("current auth in my app: ${userAuth?.user}");
    devService.log("current initial route in my app: ${initialRoute}");

    // devService.log(
    //     "this is auth state from the provider inherited BUT IN THE MAIN: $userAuth");

// TODO should provide auth state to this
// TODO THIS HAS TOBE WRAPPED IN THE PROVIDER
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
        // routes: routes,
        // home: Home,
        // initialRoute: Routes.rootRoute,
        // initialRoute: initialRoute,
        // TODO i like this because we can set arghuments here
        onGenerateRoute: onGenerateRoute,
        // TODO try using initialRoute again - it should work now when actually initializing super state - because ia wasnt before
        home: getHomePage(),
        // onGenerateInitialRoutes: onGenerateInitialRoutes,

        // onGenerateInitialRoutes: (route) {
        //   devService.log("this is initial log: $route");
        //   if (userAuth == null) {
        //     return [MaterialPageRoute(builder: (context) => LoginScreen())];
        //   }
        //   return [MaterialPageRoute(builder: (context) => HomeScreen())];
        // },

        // onGenerateRoute: AppRouter.generateRoute,
        // initialRoute: initialRoute,

        // onGenerateInitialRoutes: (String initialRoute) {
        //   devService.log(
        //       "this is intiial route in initial rotue generater: $initialRoute");

        //   devService.log("this is intiial user auth status: ${userAuth?.user}");

        //   if (initialRoute == Routes.homeRoute) {
        //     return [MaterialPageRoute(builder: (context) => HomeScreen())];
        //   }

        //   return [MaterialPageRoute(builder: (context) => LoginScreen())];
        // },

        // TODO this is not needed
        // initialRoute: homeRoute,
        // initialRoute: matchViewRoute,
        // initialRoute: initialRoute
        // and here we render login page as intial route if there is no auth, and home route if there is auth
      ),
    );
  }
}

// class RootRoute extends StatelessWidget {
//   RootRoute({Key? key}) : super(key: key);

//   final AuthController _authController = AuthController();

//   @override
//   Widget build(BuildContext context) {
//     final authState = _authController.authState(context);
//     devService.log("this is auth state in root route: $authState");

//     return authState == null ? LoginScreen() : HomeScreen();
//   }
// }
