class PlayersMutations {
  static String insertPlayer() => '''
  insert into "player" 
    (
      "user_id",
      "match_id",
      "status"
    )
  values
    (
      ?,
      ?,
      ?
    );
  ''';
}
