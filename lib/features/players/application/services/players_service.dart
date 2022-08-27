import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/data/repositories/players_repository.dart';
import 'package:five_on_four/features/players/presentation/players_controller.dart';

class PlayersService {
  late PlayersRepository _playersRepositoryProvider;

  PlayersService({required PlayersRepository playersRepositoryProvider}) {
    _playersRepositoryProvider = playersRepositoryProvider;
  }

  Future<void> updatePlayer(Player player) async {
    return _playersRepositoryProvider.updateOne(player);
  }

  Future<void> removePlayer(int playerId) async {
    return _playersRepositoryProvider.deleteOne(playerId);
  }

  Future<int> createPlayer(InsertPlayerArgs args) async {
    return await _playersRepositoryProvider.insertOne(args);
  }
}
