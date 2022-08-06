import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
import 'package:five_on_four/features/matches/data/repositories/types.dart';
import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/services/dev/dev_service.dart';

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
    final match = await _matchesRepositoryProvider.getOne(matchId);

    // devService.log("MATCH IN service: $match");

    return match;
  }

  Future<int> insertMatch(InsertMatchArgs args) async {
    // TODO possibly here we would do some validation?
    /* 
    - can user create a match 
    - maybe couuld also use player repository 
    - i am not sure 
    - but controller itself sould convert arguments from UI into isnert match args 
    - and then i gess the cotnroller will eventuallly also redirect use to the match page, and pass the match id argument 
    
     */

    final matchId = await _matchesRepositoryProvider.insertOne(args);

    return matchId;
  }
}
