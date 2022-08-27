import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/presentation/players_controller.dart';

abstract class PlayersRepository {
  // TODO not sure if i would want this to return void or actual player
  Future<void> updateOne(Player player);
  Future<void> deleteOne(int playerId);
  Future<int> insertOne(InsertPlayerArgs args);
}
