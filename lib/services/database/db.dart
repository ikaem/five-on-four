import 'package:five_on_four/features/matches/data/repositories/database/queries.dart';
import 'package:five_on_four/services/database/constants.dart';
import 'package:five_on_four/services/database/exceptions.dart';
import 'package:five_on_four/services/database/queries.dart';
import 'package:five_on_four/services/database/seed.dart';
import 'package:five_on_four/services/database/types.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// todo CURIOUS if this would make it a singleton
// or if this anotnation would work - not sure if this is a proper approach
// @protected
class Db {
  Database? _db;

  // singleton implementation
  // fi9rst specify instance of the class which is static and private, to call private constructor
  static final Db _instance = Db._internal();
  // then define factory contructor which will return the instance
  factory Db() {
    return _instance;
  }
  // then define private constructor which is called by the _instance - this is the real constructor
  Db._internal() {
    // if some implementation is needed
    // possibly, maybe i can open db here
  }

//  TODO this could be potentually used in app itself to open database immeidately after db opens
  // Future<void> _open(String dbName) async {
  Future<void> initialize() async {
    print("test");
    if (_db != null) throw DatabaseAlreadyOpenException();

    print("passed: $_db");

    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, DatabaseConstants.dbFileName);

      // now we open the db
      // this would create db even if it does not exist on this path
      final db = await openDatabase(dbPath);
      _db = db;

      await db.execute(DatabaseQueries.createMatchTable);
      await db.execute(DatabaseQueries.createPlayerTable);

      print("passed creaing tables");

      // TODO here check if this is dev envrionment
      // await _seedData(db);

      // TODO we only want to seed this data if we are in development
      // TODO how to check if we are in development

      // caching all matches
      // TODO implement this later - not sure if this should be implemented here
      // read notes from free code camp
      // this actually puts stuff into stream - and im not sure this is where this should go to
      // maybe it could go to a provider that will use this thing?

      // await _cacheMatches();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    } catch (e) {
      print("this is error: $e");
      throw UnableToOpenDatabaseException();
    }
  }

  Future<List<Map<String, Object?>>> queryRaw(String sql,
      [List<Object?>? arguments]) async {
    await _makeSureDbIsInitialized();
    final db = _getDatabaseOrThrow();

    final response = await db.rawQuery(sql, arguments);

    return response;
  }

  Future<List<Map<String, Object?>>> query(QueryArgs queryArgs) async {
    await _makeSureDbIsInitialized();
    final db = _getDatabaseOrThrow();

    final response = await db.query(
      queryArgs.tableName,
      columns: queryArgs.queryOptions?.columns,
      distinct: queryArgs.queryOptions?.distinct,
      groupBy: queryArgs.queryOptions?.groupBy,
      having: queryArgs.queryOptions?.having,
      limit: queryArgs.queryOptions?.limit,
      offset: queryArgs.queryOptions?.offset,
      orderBy: queryArgs.queryOptions?.orderBy,
      where: queryArgs.queryOptions?.where,
      whereArgs: queryArgs.queryOptions?.whereArgs,
    );

    return response;
  }

  // helpers
  Future<void> _makeSureDbIsInitialized() async {
    try {
      await initialize();
    } on DatabaseAlreadyOpenException {
      // it is fine if db is already open
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;

    if (db == null) throw DatabaseIsNotOpenException();

    return db;
  }

  // TODO only for use in dev
  Future<void> _seedData(Database db) async {
    final allMatchesBeforeDelete = await db.rawQuery(Seed.getAllMatches());
    final allPlayersBeforeDelete = await db.rawQuery(Seed.getAllPlayers());
    final allMatchesWithPlayersBeforeDelete =
        await db.rawQuery(Seed.getAllMatchesWithPlayers());
    print("matches before delete: $allMatchesBeforeDelete");
    print("players before delete: $allPlayersBeforeDelete");
    print(
        "matches with players before delete: $allMatchesWithPlayersBeforeDelete");

    await db.rawQuery(Seed.deleteAllMatches());
    await db.rawQuery(Seed.deleteAllPlayers());

    final allMatchesAfterDelete = await db.rawQuery(Seed.getAllMatches());
    final allPlayersAfterDelete = await db.rawQuery(Seed.getAllPlayers());
    print("matches after delete: $allMatchesAfterDelete");
    print("players after delete: $allPlayersAfterDelete");

// TODO transaction should commit automatically if no errors
    await db.transaction((trx) async {
      // TODO check to make sure that this actually returns just one instead of multiple ids
      final matchIdsRows = await trx.rawInsert(Seed.insertMatches());

      // print("passed creating matches, $matchIdsRows");
      final insertedMatchesRows = await trx.rawQuery(Seed.getAllMatches());

      // print("added matches - $insertedMatchesRows");

      for (var matchRow in insertedMatchesRows) {
        // print("this is match row: $matchRow");
        await trx.rawInsert(Seed.insertMatchPlayers(matchRow["id"] as int));
      }
    });
  }

  // TODO dont forget implemeing close mehtodf - checm my_notes project in repo
}

// TODO wondering if this would work, just to import it
// TODO also, could we pass a db to the data repository in matches feature, as a dependency injection? where would this be passed from? from the provider?
// for instsance, if in testing i just wand a fake database, which would return predefined stuff when a method is called
// but how can we then make stuff generic?
// final db = Db();
