import 'dart:async';

import 'package:five_on_four/features/authentication/domain/models.dart';

class AuthStateStream {
  late final StreamController<Auth?> _authStreamController;
  Auth? _auth;
  // todo NOT SURE IF I NEED CACHED DATA

  // singleton
  static final AuthStateStream _instance = AuthStateStream._internal();
  factory AuthStateStream() {
    return _instance;
  }
  // THIS IS REAL constructor
  // we will initialzaze the stream here - just braodast it on
  // and also, whenerever someone sbuscribes, we wantto add all notes to its sink
  AuthStateStream._internal() {
    // TODO can we do this?

    // and how here we can intiialze the cotnrolelr for strea
    _authStreamController = StreamController<Auth?>.broadcast(onListen: () {
      _authStreamController.sink.add(_auth);
    });
    // TODO not sure if we need to broadcast because only one subscriber exists
    // StreamController<Auth?>.broadcast(onListen: () {
    // // TODO not sure if this would work
    // _authStreamController.sink.add(_matches);
    // // _matchesStreamController.sink;
    // });
  }

  void setAuth(Auth? auth) {
    _auth = auth;
    _authStreamController.add(_auth);
  }

  Future<dynamic> closeStreamController() async {
    await _authStreamController.close();
  }

  Stream<Auth?> get authStream => _authStreamController.stream;
  // TODO testing
  Future<Auth?> get auth => authStream.last;
}
