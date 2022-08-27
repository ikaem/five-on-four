import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/cupertino.dart';

class AuthStateInherited extends InheritedWidget {
  // lets try with static
  final Auth? auth;

// this also passes child to super
  AuthStateInherited({Key? key, required this.auth, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    devService.log("testing that update should");
    return true;
  }

// might not be needed
  // void setAuth(Auth? newAuth) {
  //   auth = newAuth;
  // }

  // now create of
  // amybe it should not be static, becuase we are not actually having static data that we store
  static AuthStateInherited? of(BuildContext context) {
    final AuthStateInherited? authState =
        context.dependOnInheritedWidgetOfExactType<AuthStateInherited>();

    // if (authState == null) return null;

    // return authState._auth;

// TODO should we ! the whole thing so it is not pottentually null
    return authState;
  }

  // setter for state, static
  // i am not sure this would every work, though
  // static void setAuth(Auth? auth) {
  //   _auth = auth;
  // }

}
