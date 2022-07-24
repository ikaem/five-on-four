import 'package:five_on_four/services/database/constants.dart';
import 'package:five_on_four/services/database/types.dart';

class MatchesQueryArgs extends QueryArgs {
  MatchesQueryArgs({
    QueryOptions? queryOptions,
  }) : super(
          tableName: DatabaseConstants.matchTableName,
          queryOptions: queryOptions,
        );
}
