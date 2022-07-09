import 'package:five_on_four/constants/routes.dart';
import 'package:five_on_four/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  // TODO what does this do exactly
  // do we need to run it?
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Five On Four",
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
    routes: {
      homeRoute: (context) => HomeView(),
    },
    initialRoute: homeRoute,
  ));
}
