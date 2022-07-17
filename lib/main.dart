import 'package:five_on_four/constants/routes.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/views/home_view.dart';
import 'package:five_on_four/views/matches/match_edit_view.dart';
import 'package:five_on_four/views/matches/match_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  // TODO what does this do exactly
  // do we need to run it?
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Five On Four",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
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
