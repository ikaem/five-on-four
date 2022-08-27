import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/data/repositories/database/mutations.dart';
import 'package:five_on_four/features/players/data/repositories/database/players_database_repository.dart';
import 'package:five_on_four/features/players/data/repositories/players_repository.dart';
import 'package:five_on_four/features/players/presentation/players_controller.dart';
import 'package:five_on_four/services/database/db.dart';

class PlayersRepositoryProvider implements PlayersRepository {
  late final PlayersRepository _playersRepository;

  PlayersRepositoryProvider(this._playersRepository);

  PlayersRepositoryProvider.database(Db db) {
    _playersRepository = PlayersDatabaseRepository(db);
  }

  @override
  Future<void> updateOne(Player player) async {
    return await _playersRepository.updateOne(player);
  }

  @override
  Future<void> deleteOne(int playerId) async {
    return await _playersRepository.deleteOne(playerId);
  }

  @override
  Future<int> insertOne(InsertPlayerArgs args) async {
    return await _playersRepository.insertOne(args);
  }
}
