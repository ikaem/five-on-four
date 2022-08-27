import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/data/repositories/database/mutations.dart';
import 'package:five_on_four/features/players/data/repositories/players_repository.dart';
import 'package:five_on_four/features/players/presentation/players_controller.dart';
import 'package:five_on_four/services/database/db.dart';

class PlayersDatabaseRepository implements PlayersRepository {
  final Db _db;
  PlayersDatabaseRepository(this._db);

  @override
  Future<void> updateOne(Player player) async {
    final dbConnection = await _db.getConnection;

    await dbConnection.rawQuery(PlayersMutations.updatePlayer(),
        [player.userId, player.matchId, player.matchStatus, player.id]);
  }

  @override
  Future<void> deleteOne(int playerId) async {
    final dbConnection = await _db.getConnection;

    await dbConnection.rawQuery(PlayersMutations.deletePlayer(), [playerId]);
  }

  @override
  Future<int> insertOne(InsertPlayerArgs args) async {
    final dbConnection = await _db.getConnection;
    final id = await dbConnection.rawInsert(PlayersMutations.insertPlayer(),
        [args.userId, args.matchId, args.matchStatus]);

    return id;
  }
}
