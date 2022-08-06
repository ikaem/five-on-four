class PlayersMutations {
  static String insertPlayer() => '''
  insert into "player" 
    (
      "nickname",
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
