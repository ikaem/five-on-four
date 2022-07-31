import 'dart:async';

import 'package:five_on_four/features/matches/domain/index.dart';

class MatchesState {
  late final StreamController<List<Match>> _matchesController;
  List<Match> _matches = [];

  // singleton
  static final MatchesState _instance = MatchesState._internal();
  factory MatchesState() {
    return _instance;
  }
  // THIS IS REAL constructor
  // we will initialzaze the stream here - just braodast it on
  // and also, whenerever someone sbuscribes, we wantto add all notes to its sink
  MatchesState._internal() {
    // TODO can we do this?

    // and how here we can intiialze the cotnrolelr for strea
    _matchesController = StreamController<List<Match>>.broadcast(onListen: () {
      _matchesController.sink.add(_matches);
    });
  }

  void cacheMatches(List<Match> matches) {
    // this step is needed to make sure on listen has correct matches to put to sink
    _matches = matches;
    _matchesController.add(_matches);
  }

  Stream<List<Match>> get matchesStream => _matchesController.stream;
  List<Match> get cachedMatches => [..._matches];
}
