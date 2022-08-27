import 'package:five_on_four/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authController = AuthController();

  @override
  void initState() {
    _authController.checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = _authController.currentAuth;
    // devService
    //     .log("this is auth state from the provider inherited: ${authState.then(
    //   (value) => value == null ? 0 : "Not null",
    // )}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        actions: <Widget>[AppBarPopupMenu()],
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text("Login"),
            onPressed: () async {
              await _authController.loginUser();
            },
          ),
        ),
      ),
    );
  }
}
