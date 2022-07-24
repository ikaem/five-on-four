import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/navigation/routes.dart';
import 'package:five_on_four/screens/home_screen.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  await db.initialize();
  // TODO what if this throws error to say that db is already open - just catch it?

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
