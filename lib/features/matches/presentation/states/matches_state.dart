import 'dart:async';

import 'package:five_on_four/features/matches/domain/index.dart';

class MatchesStateStream {
  late final StreamController<List<Match>> _matchesStreamController;
  List<Match> _matches = [];

  // singleton
  static final MatchesStateStream _instance = MatchesStateStream._internal();
  factory MatchesStateStream() {
    return _instance;
  }
  // THIS IS REAL constructor
  // we will initialzaze the stream here - just braodast it on
  // and also, whenerever someone sbuscribes, we wantto add all notes to its sink
  MatchesStateStream._internal() {
    // TODO can we do this?

    // and how here we can intiialze the cotnrolelr for strea
    _matchesStreamController =
        StreamController<List<Match>>.broadcast(onListen: () {
      // TODO not sure if this would work
      _matchesStreamController.sink.add(_matches);
      // _matchesStreamController.sink;
    });
  }

  void cacheMatches(List<Match> matches) {
    // this step is needed to make sure on listen has correct matches to put to sink
    _matches = matches;
    _matchesStreamController.add(_matches);
  }

  Stream<List<Match>> get matchesStream => _matchesStreamController.stream;
  List<Match> get cachedMatches => [..._matches];
}
