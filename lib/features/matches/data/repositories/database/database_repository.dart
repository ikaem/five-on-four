import 'package:five_on_four/features/matches/data/repositories/database/queries.dart';
import 'package:five_on_four/features/matches/data/repositories/database/types.dart';
import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
import 'package:five_on_four/features/matches/domain/models/match.dart';
import 'package:five_on_four/services/database/db.dart';

class DatabaseRepository implements MatchesRepository {
  // TODO this repository should be initialized osmehow, too
  // https://codewithandrea.com/articles/flutter-repository-pattern/

  // or this one, simpler
  // https://blog.logrocket.com/implementing-repository-pattern-flutter/
  final Db _db;
  DatabaseRepository(this._db);

  @override
  Future<List<Match>> getMatches() async {
    // final matchesRows = await _db.query(MatchesQueryArgs());
    final matchesRows =
        await _db.queryRaw(MatchesQueries.getAllMatchesWithPlayers());
    final matches =
        matchesRows.map<Match>((mr) => Match.fromDbRow(mr)).toList();

    return matches;

    // TODO and now we can transform data here
    // later, he says that we might use some provider
    // or we should be initi
  }
}
