import 'package:five_on_four/features/matches/domain/models/index.dart'
    show Match;
import 'package:five_on_four/services/database/db.dart';

abstract class MatchesRepository {
// TODO eventually we might be passing arguments here to define which matches we
  Future<List<Match>> getMatches();
}
