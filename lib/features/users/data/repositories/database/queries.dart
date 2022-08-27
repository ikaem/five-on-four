class UsersQueries {
  // TODO nickname should be indexed
  static String searchUsersByNickname() => '''
  select 
    id,
    nickname
  from user u
  where nickname like ?;
  ''';
}
