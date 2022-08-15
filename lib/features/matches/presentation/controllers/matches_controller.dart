import 'dart:async';

import 'package:five_on_four/features/matches/application/services/matches_service.dart';
import 'package:five_on_four/features/matches/data/repositories/matches_repository_provider.dart';
import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/features/matches/presentation/states/matches_state.dart';
import 'package:five_on_four/features/users/doman/models/user.dart';
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

  // Future<void> createMatch(
  //     String name,
  //     String data,
  //     String time,
  //     String location,
  //     // TODO this might be a string, since from input
  //     int maxPlayers,
  //     String description,
  //     String organizerPhoneNumber,

  //     // how do we provide list of these
  //     // is there a way to have input controller store a list of values,
  //     // or how do we create multiple controllers
  //     // or how do we create inputs dynamically
  //     List<int> invitedPlayerIds) async {}

  Future<Match?> loadMatch(int matchId) async {
    List<Match> cachedMatches = _matchesState.cachedMatches;

    final match = await _matchesService.getMatch(matchId);

    devService.log("here in controller, ${match?.id}");

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

  // TODO test
  // TODO this function should probably return match id - will need to figure out how to get that from transaction and batch
  // should not be a problem, becuase inserting match will be a regular transaction - this can return value no problem
  // while inserting players will be a batch function

  Future<int> createMatch({
    required String matchName,
    required String matchDateTime,
    required String matchDuration,
    required String matchLocation,
    required String matchMaxPlayers,
    required String matchDescription,
    required String matchOrganizerPhoneNumber,
    required List<User?> matchInvitedUsers,
  }) async {
    final insertMatchArgs = generateInsertMatchArgs(
      matchName: matchName,
      matchDateTime: matchDateTime,
      matchDuration: matchDuration,
      matchLocation: matchLocation,
      matchMaxPlayers: matchMaxPlayers,
      matchDescription: matchDescription,
      matchOrganizerPhoneNumber: matchOrganizerPhoneNumber,
      matchInvitedUsers: matchInvitedUsers,
    );

    devService.log("test log args: ${insertMatchArgs.matchInvitedUserIds}");

    // and now call service

    // TODO test return

    final matchId = await _matchesService.insertMatch(insertMatchArgs);

    return matchId;
  }

  Stream<List<Match>> get matchesStream => _matchesState.matchesStream;
}

// this is test - this model, org args, should live somewhere else
class InsertMatchArgs {
  String matchName;
  // TODO these possibly should be date time and not string
  String matchDateTime;
  int matchDuration;
  String matchLocation;
  int matchMaxPlayers;
  String matchDescription;
  String matchOrganizerPhoneNumber;
  List<int> matchInvitedUserIds;

  InsertMatchArgs(
      this.matchName,
      this.matchDateTime,
      this.matchDuration,
      this.matchLocation,
      this.matchMaxPlayers,
      this.matchDescription,
      this.matchOrganizerPhoneNumber,
      this.matchInvitedUserIds);
}

// TODO move this to helpers somewhere
InsertMatchArgs generateInsertMatchArgs({
  required String matchName,
  required String matchDateTime,
  required String matchDuration,
  required String matchLocation,
  required String matchMaxPlayers,
  required String matchDescription,
  required String matchOrganizerPhoneNumber,
  required List<User?> matchInvitedUsers,
}) {
  final normalizedName = matchName.trim();
  // TODO this default value should probably be offered to user as a default anyhow
  final normalizedDateTime = DateTime.parse(matchDateTime).toIso8601String();
  final duration = double.tryParse(matchDuration) ?? 1.0;
  final normalizedDurationInMilliseconds = (duration * 60 * 60 * 1000).toInt();
  final normalizedLocation = matchLocation.trim();
  // same thing here - 12 should be a default option
  final normalizedMaxPlayers = int.tryParse(matchMaxPlayers) ?? 12;
  final normalizedDescription = matchDescription.trim();
  final normalizedPhoneNumber = matchOrganizerPhoneNumber.trim();
  final normalizedUserIds = matchInvitedUsers.where((u) {
    final user = u;
    if (user == null) return false;
    return true;
  }).map((u) {
    // TODO here we know that user cannot be null
    return u!.id;
  }).toList();

  final matchArgs = InsertMatchArgs(
    normalizedName,
    normalizedDateTime,
    normalizedDurationInMilliseconds,
    normalizedLocation,
    normalizedMaxPlayers,
    normalizedDescription,
    normalizedPhoneNumber,
    normalizedUserIds,
  );

  return matchArgs;
}
