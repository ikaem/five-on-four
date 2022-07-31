import 'package:five_on_four/services/database/constants.dart';
import 'package:five_on_four/services/database/queries.dart';
import 'package:five_on_four/services/database/types.dart';

class MatchesQueries {
  static String getAllMatchesWithPlayers() => '''
  select 
    m.id,
    m."date",
    m."time",
    m."name",
    m."location",
    m.max_players,
    m.description,
    m.phone_number,
    p.id as "player_id",
    p.nickname as "player_nickname",
    p.status as "player_status",
    p.match_id as "player_match_id"
  from "match" m 
  left join player p on p.match_id = m.id 
  group by 
    m.id,
    m."date",
    m."time",
    m."name",
    m."location",
    m.max_players,
    m.description,
    m.phone_number,
    p.id,
    p.nickname,
    p.status,
    p.match_id
  order by 
    p.match_id;
  ''';

  static String getOneMatchWithPlayers() => '''
  select 
    m.id,
    m."date",
    m."time",
    m."name",
    m."location",
    m.max_players,
    m.description,
    m.phone_number,
    p.id as "player_id",
    p.nickname as "player_nickname",
    p.status as "player_status",
    p.match_id as "player_match_id"
  from "match" m 
  left join player p on p.match_id = m.id 
  where m.id = ?;
  ''';
}
