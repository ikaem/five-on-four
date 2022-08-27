import 'package:five_on_four/features/matches/data/repositories/database/queries.dart';

class DatabaseQueries {
  static const createUsersTable = '''
  CREATE TABLE "user" (
    "id"	INTEGER NOT NULL UNIQUE,
    "nickname"	TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
  ''';

  static const createMatchTable = '''
  CREATE TABLE IF NOT EXISTS "match" (
    "id"	INTEGER NOT NULL,
    "datetime"	TEXT NOT NULL,
    "duration"	INTEGER NOT NULL,
    "name"	TEXT NOT NULL,
    "location"	TEXT NOT NULL,
    "max_players"	INTEGER NOT NULL,
    "description"	TEXT NOT NULL,
    "phone_number"	TEXT NOT NULL,
    "organizer_id"	INTEGER NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT),
	  FOREIGN KEY("organizer_id") REFERENCES "user"("id") ON DELETE CASCADE
  );
  ''';

  static const createPlayerTable = '''
  CREATE TABLE IF NOT EXISTS "player" (
    "id"	INTEGER NOT NULL,
    "user_id"	INTEGER NOT NULL,
    "match_id"	INTEGER NOT NULL,
    "status"	TEXT NOT NULL,
    FOREIGN KEY("match_id") REFERENCES "match"("id") ON DELETE CASCADE,
    FOREIGN KEY("user_id") REFERENCES "user"("id") ON DELETE CASCADE,
    PRIMARY KEY("id" AUTOINCREMENT)
  );
  ''';
}
