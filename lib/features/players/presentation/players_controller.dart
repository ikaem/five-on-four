import 'package:five_on_four/features/matches/constants/index.dart';
import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/players/application/services/players_service.dart';
import 'package:five_on_four/features/players/data/repositories/players_repository_provider.dart';
import 'package:five_on_four/services/database/db.dart';

// TODO this could accept some argument, or have a named constructor to get only firebase or database controller
class PlayersController {
  // singleton
  static final PlayersController _instance = PlayersController._internal();
  factory PlayersController() {
    return _instance;
  }
  PlayersController._internal();
  //

  final PlayersService _playersService = PlayersService(
      playersRepositoryProvider: PlayersRepositoryProvider.database(Db()));

  Future<void> acceptPlayerMatchInvitation(Player player) async {
    // just change playaers match status
    player.matchStatus = PlayerMatchStatusLabel.joined;

    await _playersService.updatePlayer(player);
  }

  Future<void> unjoinPlayerMatchWaitingList(Player player) async {
    // just change playaers match status
    // player.matchStatus = PlayerMatchStatusLabel.joined;

    // await _playersService.updatePlayer(player);
    await _playersService.removePlayer(player.id);
  }

  Future<void> unjoinPlayerMatch(Player player) async {
    // just change playaers match status
    // player.matchStatus = PlayerMatchStatusLabel.joined;

    // await _playersService.updatePlayer(player);
    await _playersService.removePlayer(player.id);
  }

// TODO this depends - if the player is invited, and joins, we need to update
// but if a user just want to joins waiting list, we do need to create new player
  Future<void> joinPlayerMatchWaitingList(Player player) async {
    // just change playaers match status
    // TODO this are final fields, not sure if this will work with reassigning variable
    player.matchStatus = PlayerMatchStatusLabel.onWaitingList;

    await _playersService.updatePlayer(player);
  }

  Future<void> joinUserMatch(int matchId, int userId) async {
    // just change playaers match status
    // no - this needs to create a player - so we cannot really pass it player
    // player.matchStatus = PlayerMatchStatusLabel.joined;

    final args = InsertPlayerArgs(
      matchId: matchId,
      userId: userId,
      matchStatus: PlayerMatchStatusLabel.joined,
    );

    await _playersService.createPlayer(args);
  }
}

// TODO this needs to be moved to types somewhere
class InsertPlayerArgs {
  final int matchId;
  final int userId;
  final String matchStatus;

  InsertPlayerArgs({
    required this.matchId,
    required this.userId,
    required this.matchStatus,
  });
}
