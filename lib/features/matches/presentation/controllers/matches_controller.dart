import 'dart:async';

import 'package:five_on_four/features/matches/application/services/matches_service.dart';
import 'package:five_on_four/features/matches/data/repositories/matches_repository_provider.dart';
import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/features/matches/presentation/states/matches_state.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';

// THIS does not really need to be singleton - state will have to be singleton, but this does not need to
class MatchesController {
  final MatchesState _matchesState = MatchesState();
  final MatchesService _matchesService = MatchesService(
    // TODO how to make this dynamic - how to make it able to use another db for testing?
    // maybe pass some env variable that holds path to a testing database?
    matchesRepositoryProvider: MatchesRepositoryProvider.database(Db()),
  );
  // late final StreamController<List<Match>> _matchesController;
  // List<Match> _matches = [];

  // singleton
  static final MatchesController _instance = MatchesController._internal();
  factory MatchesController() {
    return _instance;
  }
  // THIS IS REAL constructor
  // we will initialzaze the stream here - just braodast it on
  // and also, whenerever someone sbuscribes, we wantto add all notes to its sink
  MatchesController._internal() {
    // TDOO implementation not needed anymore
    // TODO can we do this?

    // and how here we can intiialze the cotnrolelr for strea
    // _matchesController = StreamController<List<Match>>.broadcast(onListen: () {
    //   _matchesController.sink.add(_matches);
    // });
  }

  // void _cacheMatches(List<Match> matches) {
  //   // this step is needed to make sure on listen has correct matches to put to sink
  //   _matches = matches;
  //   _matchesController.add(_matches);
  // }

  Future<void> loadMatches() async {
    final matches = await _matchesService.getAllMatches();

    // devService.log("matches here: $matches");

    _matchesState.cacheMatches(matches);
    // _cacheMatches(matches);
  }

  Future<Match?> loadMatch(int matchId) async {
    List<Match> cachedMatches = _matchesState.cachedMatches;
    final match = await _matchesService.getMatch(matchId);

    if (match == null) {
// TODO remove this match from cached matches

      cachedMatches.removeWhere((match) => match.id == matchId);
      _matchesState.cacheMatches(cachedMatches);
      return null;
    }

    // check if match already exists in the cached matches
    final loadedMatchIndex =
        cachedMatches.indexWhere((match) => match.id == matchId);

    // i9f it does exist, update it with new match
    if (loadedMatchIndex == -1) {
      cachedMatches.add(match);
    } else {
      cachedMatches[loadedMatchIndex] = match;
    }

    // if it does not exist, add it

    _matchesState.cacheMatches(cachedMatches);

    // and return match;
    return match;
  }

  Stream<List<Match>> get matchesStream => _matchesState.matchesStream;
}
