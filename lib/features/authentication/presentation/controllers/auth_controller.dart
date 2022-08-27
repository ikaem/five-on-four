import 'package:five_on_four/features/authentication/application/services/auth_service.dart';
import 'package:five_on_four/features/authentication/data/repositories/auth_repository_provider.dart';
import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/features/authentication/presentation/providers/auth_provider.dart';
import 'package:five_on_four/features/authentication/presentation/state/auth_state.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:flutter/cupertino.dart';

class AuthController {
  // this is temp solution to hold auth state - should have some better one eventually
  static Auth? _auth;

  final AuthStateStream _authState = AuthStateStream();

  final AuthService _authService = AuthService(
      authRepositoryProvider: AuthRepositoryProvider.database(Db()));

  static final AuthController _instance = AuthController._internal();
  factory AuthController() {
    return _instance;
  }
  AuthController._internal() {
    // checkSession();
  }

  // TODO this is private because only this controlelr will use it

  // this could be a function to

// TODO because of this, might not be needed to notify? bit it might be needed too
  Auth? authState(BuildContext context) => AuthStateInherited.of(context)?.auth;

// practice with this inherited widget thing is probably not the best, because i keep having to pass context
// what is with that Provider library
// WILL NEED TO provide args
  Future<Auth?> loginUser() async {
    // final setAuth = AuthStateInherited.of(context)?.setAuth;
    // if (setAuth == null) return;

    final loginAuth = await _authService.loginAuth();

    // setAuth(auth);

    // return auth;
    _auth = loginAuth;
    _authState.setAuth(loginAuth);

    return _auth;
  }

  Future<Auth?> checkSession() async {
    // final setAuth = AuthStateInherited.of(context)?.setAuth;
    // if (setAuth == null) return;

    final sessionAuth = await _authService.sessionAuth();

    // setAuth(auth);

    _auth = sessionAuth;

    _authState.setAuth(sessionAuth);

    return _auth;
  }

  Future<Auth?> get currentAuth => _authState.auth;
  Stream<Auth?> get authStream => _authState.authStream;

  closeStreamController() async {
    await _authState.closeStreamController();
  }

  // get authStream => _authState.
}
