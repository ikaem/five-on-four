class MatchesMutations {
  static String insertMatch() => '''
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
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?
    );
  ''';
}
