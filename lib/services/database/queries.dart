import 'package:five_on_four/features/matches/data/repositories/database/queries.dart';

class DatabaseQueries {
  static const createMatchTable = '''
  CREATE TABLE IF NOT EXISTS "match" (
    "id"	INTEGER NOT NULL,
    "date"	TEXT NOT NULL,
    "time"	TEXT NOT NULL,
    "name"	TEXT NOT NULL,
    "location"	TEXT NOT NULL,
    "max_players"	INTEGER NOT NULL,
    "description"	TEXT NOT NULL,
    "phone_number"	TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
  ''';

  static const createPlayerTable = '''
  CREATE TABLE IF NOT EXISTS "player" (
    "id"	INTEGER NOT NULL,
    "nickname"	TEXT NOT NULL,
    "match_id"	INTEGER NOT NULL,
    "status"	TEXT NOT NULL,
    FOREIGN KEY("match_id") REFERENCES "match"("id") ON DELETE CASCADE,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
  ''';
}
