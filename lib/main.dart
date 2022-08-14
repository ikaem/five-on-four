import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/screens/home_screen.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
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
  // TODO what if this throws error to say that db is already open - just catch it?

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

// TODO this should probably make it ll stateful widget
// TODO or this should maybe go to home page?
// TODO it should probably be in the home page, because here we dont need matches
  final MatchesController _matchesController = MatchesController();

  @override
  Widget build(BuildContext context) {
// TODO this should probably live in some init state or something
    _matchesController.loadMatches();

    return MaterialApp(
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
      routes: AppRouter.generateRoutes(context),
      // TODO this is not needed
      // initialRoute: homeRoute,
      // initialRoute: matchViewRoute,
    );
  }

  _generateRoutes(BuildContext context) {
    return AppRouter.generateRoutes(context);
  }
}
