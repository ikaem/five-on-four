class User {
  late final int id;
  late final String nickname;
  // TODO should probably add email soon

  User({
    required this.id,
    required this.nickname,
  });

  User.fromDbRow(Map<String, Object?> row) {
    id = row["id"] as int;
    nickname = row["nickname"] as String;
  }
}
