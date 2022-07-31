import 'package:five_on_four/features/matches/data/repositories/database/matches_database_repository.dart';
import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
import 'package:five_on_four/features/matches/domain/models/match.dart';
import 'package:five_on_four/services/database/db.dart' show Db;
import 'package:five_on_four/services/dev/dev_service.dart';

class MatchesRepositoryProvider implements MatchesRepository {
  late final MatchesRepository _matchesRepository;

  MatchesRepositoryProvider(this._matchesRepository);

// TJIS IS ALSO A CONTRUTOR
// but we bass it explicitely databse repository
  MatchesRepositoryProvider.database(Db db) {
    // MatchesRepositoryProvider(MatchesDatabaseRepository(db));
    _matchesRepository = MatchesDatabaseRepository(db);
  }

  // TODO this would be a factory option
  factory MatchesRepositoryProvider.databaseWithFactory(Db db) =>
      // Nnote that we have to return this class from here, to make sure we have access to providrs mehtods, nad not repositroy's direct methods
      MatchesRepositoryProvider(
        MatchesDatabaseRepository(db),
      );

  @override
  Future<List<Match>> getAll() async {
    final all = await _matchesRepository.getAll();
    // devService.log("all: $all");

    return all;
  }

  @override
  // TODO later add throwing erros if no match, so this does not have to be optional
  Future<Match?> getOne(int matchId) async {
    final one = await _matchesRepository.getOne(matchId);
    return one;
  }
}
