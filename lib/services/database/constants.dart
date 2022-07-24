// lib\features\matches\constants\sqlite_matches.dart

// TODO this is questionable whether shis should be in the feature, or if it should actually be general repo?
// maybe here, if we have some microservice kind of architecture

class DatabaseConstants {
  static const dbFileName = "five_on_four.db";
  static const matchTableName = "match";
  static const playerTableName = "player";
  // TODO in future, this could hold
  // - teams
  // - players
  // - competitions
}
