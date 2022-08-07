import 'package:five_on_four/services/database/constants.dart';
import 'package:five_on_four/services/database/queries.dart';
import 'package:five_on_four/services/database/types.dart';

// TODO i need indexes everywhere where searched or whered or joined on
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
      p.user_id as "player_user_id",
      p.status as "player_status",
      p.match_id as "player_match_id",
	    u.nickname
    from "match" m 
    left join player p on p.match_id = m.id 
	left join user u on u.id = p.user_id
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
      p.user_id,
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
    p.status as "player_status",
    p.match_id as "player_match_id",
	  u.nickname as "nickname"
  from "match" m 
  left join player p on p.match_id = m.id
  left join user u on u.id = p.user_id
  where m.id = ?;
  ''';
}
