class MatchesMutations {
  static String insertMatch() => '''
  insert into "match" 
    (
      "datetime",
      "duration",
      "name",
      "location",
      max_players,
      description,
      phone_number,
      organizer_id
    )
  values
    (
      ?,
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
