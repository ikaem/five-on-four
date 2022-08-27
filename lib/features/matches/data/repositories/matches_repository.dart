import 'package:five_on_four/features/matches/data/repositories/types.dart';
import 'package:five_on_four/features/matches/domain/models/index.dart'
    show Match;
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/services/database/db.dart';

abstract class MatchesRepository {
// TODO eventually we might be passing arguments here to define which matches we
  Future<List<Match>> getAll();
  Future<Match?> getOne(int matchId);
  Future<int> insertOne(InsertMatchArgs args);
}
