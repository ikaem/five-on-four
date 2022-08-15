import 'package:five_on_four/features/matches/data/repositories/database/constants.dart';
import 'package:five_on_four/features/matches/data/repositories/database/mutations.dart';
import 'package:five_on_four/features/matches/data/repositories/database/queries.dart';
import 'package:five_on_four/features/matches/data/repositories/database/types.dart';
import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
import 'package:five_on_four/features/matches/data/repositories/types.dart';
import 'package:five_on_four/features/matches/domain/models/match.dart';
import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/index.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/data/repositories/database/mutations.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';

class MatchesDatabaseRepository implements MatchesRepository {
  // TODO this repository should be initialized osmehow, too
  // https://codewithandrea.com/articles/flutter-repository-pattern/

  // or this one, simpler
  // https://blog.logrocket.com/implementing-repository-pattern-flutter/
  final Db _db;
  MatchesDatabaseRepository(this._db);

  // TODO this is test only - it should be moved to user feature
  searchUsers() async {
    final dbConnection = await _db.getConnection;

    // final usersRows = await dbConnection.query("user", )
  }

  // TODO test
  @override
  Future<int> insertOne(InsertMatchArgs args) async {
    // TODO this sould actuaqlly accept databse, so it can query on it - so each functzion should accept database
    final dbConnection = await _db.getConnection;

    final matchId = await dbConnection.transaction((txn) async {
      final matchId = await txn.rawInsert(MatchesMutations.insertMatch(), [
        args.matchDateTime,
        args.matchDuration,
        args.matchName,
        args.matchLocation,
        args.matchMaxPlayers,
        args.matchDescription,
        args.matchOrganizerPhoneNumber
      ]);

// i could use transaction inside the loop, but that would mean mutliple statemenrt and pinging db
// with batch, we just do one ping of db
// unless we want the result - then even in batch there will be multiple resuilts
      final batch = txn.batch();

// player id will be hardcoded for now
      for (int playerId in args.matchInvitedUserIds) {
        batch.rawInsert(PlayersMutations.insertPlayer(), [
          // TODO later remove having nicknames here
          playerId,
          matchId,
          PlayerMatchStatus.invited
        ]);
      }
      // TODO here we will actually insert multiple players
      // question is how to insert multiple data with same argument

// commit will happen only if transaction succeeds here
      await batch.commit();

      return matchId;
    });

    // TODO will need to also insert mutliple rows for players
    // so maybe batch would do it?
    // or, i could actually generate query based on how many arguments we have
    // thisng is, loops actually generate values here

    // TODO all of these should maybe throw errors of some specific kind

    return matchId;
  }

  @override
  Future<List<Match>> getAll() async {
    // final matchesRows = await _db.query(MatchesQueryArgs());
    final matchesRows =
        await _db.queryRaw(MatchesQueries.getAllMatchesWithPlayers());

    // devService.log("this is matches: $matchesRows");
    // final matches =
    //     matchesRows.map<Match>((mr) => Match.fromDbRow(mr)).toList();

    final matches = transformMatchesRowsToMatches(matchesRows);

    return matches;

    // return matches;

    // TODO and now we can transform data here
    // later, he says that we might use some provider
    // or we should be initi
  }

  @override
  Future<Match?> getOne(int matchId) async {
    devService.log("in the repo query: $matchId");
    final matchRows =
        await _db.queryRaw(MatchesQueries.getOneMatchWithPlayers(), [matchId]);

    devService.log("test match rows: ${matchRows}");

    // devService.log(matchRows);

    // devService.log("here is match rows: $matchRows");

    final match = transformMatchRowsToMatch(matchRows);

    devService.log("match: $match");

    // TODO this could have the transform funciton potentially throw an error too
    // TODO and then we would njto have to return conditionaly
    // TODO - THAT MIGHT BE BETTER AND MORE ELEGANT solution
    // TODO but how to handle errors with future buuklder in UI later
    // TODO it is better because when we return errors, we can return different errors for instance
    // noit logged in, no such user, not admin and so on
    // this way we could be more informative towards the user on what went wrong
    // TODO use errors later, and check if future builder has some error handler

    print("this IS MATCH!!!, $match");

    return match;
  }
}

// TODO move to some util functions
Match? transformMatchRowsToMatch(List<Map<String, Object?>> matchRows) {
  if (matchRows.isEmpty) return null;

  devService.log("in transform: $matchRows");

  Match match = Match.fromDbRowWithEmptyPlayers(matchRows[0]);
  devService.log("pased: match - $match");

  // print("match 0: ${match.id}");

  for (Map<String, Object?> matchRow in matchRows) {
    devService.log("in the loop - $matchRow");
    Player player = Player.fromMatchDbRow(matchRow);

    // devService.log("passed another match row");
    match.players.add(player);
  }

  // devService.log("this is players: ${match.players}");
  return match;
}

// TODO this should probably go to some helpers
// TODO function to group matches
List<Match> transformMatchesRowsToMatches(
    List<Map<String, Object?>> matchesRows) {
  // devService.log("matchesRows: $matchesRows");
  // TODO first create map
  Map<int, Match> matchesMap = {};

  for (Map<String, Object?> matchRow in matchesRows) {
    int matchId = matchRow["id"] as int;
    // Player player = Player(
    //   // TODO create cosntants fwrom therse fields
    //   id: matchRow["player_id"] as int,
    //   nickname: matchRow["player_nickname"] as String,
    //   matchStatus: matchRow["player_status"] as String,
    // );

    Player player = Player.fromMatchDbRow(matchRow);

    // devService.log("this is player: $player");
    // devService.log("map: $matchesMap");

    if (!matchesMap.containsKey(matchId)) {
      // TODO this could potentually be a named cosntructor, or factory constructor
      // it would return match with empty players
      // but then we would add players
      // matchesMap[matchId] = Match(
      //   id: matchId,
      //   date: matchRow[MatchColumn.date] as String,
      //   time: matchRow[MatchColumn.time] as String,
      //   name: matchRow[MatchColumn.name] as String,
      //   location: matchRow[MatchColumn.location] as String,
      //   maxPlayers: matchRow[MatchColumn.maxPlayers] as int,
      //   description: matchRow[MatchColumn.description] as String,
      //   organizerPhoneNumber: matchRow[MatchColumn.phoneNumber] as String,
      //   players: [],
      // );

// TODO this does the same thing
      matchesMap[matchId] = Match.fromDbRowWithEmptyPlayers(matchRow);

      // print(
      //     "general match player for id: $matchId - these are players: ${matchesMap[matchId]?.players}");
    }
    matchesMap.update(matchId, (value) {
      // this is cool - we add data with cascade
      return value..players.add(player);

      // value.players.add(player);
    });
  }

  // tranbsform map to list
  final List<Match> matches = matchesMap.values.toList();

  // devService.log("this is match: ${matches[3].players}");
  // print("matches: $matches");

  return matches;
}
