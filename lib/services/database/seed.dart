class Seed {
  static String deleteAllMatches() => '''
  delete from "match";
  ''';
  static String deleteAllPlayers() => '''
  delete from "player";
  ''';

  static String getAllPlayers() => '''
    select 
      id,
      nickname,
      status,
      match_id
    from player p;
  ''';

  static String getAllMatches() => '''
    select 
      m.id,
      m."date",
      m."time",
      m."name",
      m."location",
      m.max_players,
      m.description,
      m.phone_number
    from "match" m;
  ''';
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
      p.id,
      p.nickname,
      p.status,
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

  static String insertMatchPlayers(int matchId) => '''
    insert into player 
    (
      nickname,
      status,
      match_id 
    )
    values 
    (
      'Pele',
      'joined',
      $matchId
    ),
    (
      'Maradona',
      'joined',
      $matchId
    ),
    (
      'Beckham',
      'joined',
      $matchId
    ),
    (
      'Ronaldo',
      'joined',
      $matchId
    ),
    (
      'Zidane',
      'joined',
      $matchId
    ),
    (
      'Kaka',
      'joined',
      $matchId
    );
  ''';

  static String insertMatches() => '''
    insert into "match" 
    (
      "date",
      "time",
      "name",
      "location",
      max_players,
      description,
      phone_number
    )
    values
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    ),
    (
      '7/1/2022',
      '12:18 AM',
      'Random match name',
      'Lacabamba',
      12,
      'Lorem description',
      '+123456789'
    );
    ''';
}
