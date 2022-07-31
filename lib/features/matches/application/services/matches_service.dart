import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
import 'package:five_on_four/features/matches/domain/index.dart';

class MatchesService {
  late MatchesRepository _matchesRepositoryProvider;

  MatchesService({required MatchesRepository matchesRepositoryProvider}) {
    _matchesRepositoryProvider = matchesRepositoryProvider;
  }

  Future<List<Match>> getAllMatches() async {
    // we could have another repo provider - for auth
    // and then we would get the user, or its id
    // and then we could get only that user

    return await _matchesRepositoryProvider.getAll();
  }

  Future<Match?> getMatch(int matchId) async {
    return await _matchesRepositoryProvider.getOne(matchId);
  }
}
