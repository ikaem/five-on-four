// import 'package:five_on_four/features/matches/data/repositories/matches_repository.dart';
// import 'package:five_on_four/features/matches/data/repositories/sqlite/constants.dart';
// import 'package:five_on_four/features/matches/data/repositories/sqlite/exceptions.dart';
// import 'package:five_on_four/features/matches/data/repositories/sqlite/queries.dart';
// import 'package:five_on_four/features/matches/domain/index.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart'
//     show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;
// import 'package:sqflite/sqflite.dart' show Database, openDatabase;

// // TODO this is questionable whether shis should be in the feature, or if it should actually be general repo?
// // maybe here, if we have some microservice kind of architecture

// // TODO this should only
// class SQLiteMatchesRepository implements MatchesRepository {
//   Database? _db;

//   // singleton implementation
//   static final SQLiteMatchesRepository _instance =
//       SQLiteMatchesRepository._internal();
//   // use factory constructor
//   factory SQLiteMatchesRepository() {
//     return _instance;
//   }
//   // this is real cosntrutor that will only be called once - first time the class is intiialized by the static property above
//   SQLiteMatchesRepository._internal() {
//     // we can have some intiialization logic here as well
//     // TODO wondering if we could open the db connection here, and then not check if it is open everywhere
//   }

//   Future<List<Match>> getMatches() async {
//     // this will never throw - just it will either open the db, or just move on if it is open

//     await _makeSureDbIsOpen();
//     final db = _getDatabaseOrThrow();

//     // THIS QUERY HAS TO GET ALL MATCHES, JOINED WITH THEIR USERS
//     db.execute(SQLiteQueries.getAllMatches);
//   }

//   // helpers
//   Future<void> _open() async {
//     if (_db != null) throw DatabaseAlreadyOpenException();

//     try {
//       final docsPath = await getApplicationDocumentsDirectory();
//       final dbPath = join(docsPath.path, SQLiteConstants.dbFileName);

//       // now we open the db
//       // this would create db even if it does not exist on this path
//       final db = await openDatabase(dbPath);
//       _db = db;

//       await db.execute(SQLiteQueries.createMatchTable);
//       await db.execute(SQLiteQueries.createPlayerTable);

//       // caching all matches
//       // TODO implement this later - not sure if this should be implemented here
//       // read notes from free code camp
//       // this actually puts stuff into stream - and im not sure this is where this should go to
//       // maybe it could go to a provider that will use this thing?

//       // await _cacheMatches();
//     } on MissingPlatformDirectoryException {
//       throw UnableToGetDocumentsDirectoryException();
//     } catch (e) {
//       throw UnableToOpenDatabaseException();
//     }
//   }

//   Future<void> _makeSureDbIsOpen() async {
//     try {
//       await _open();
//     } on DatabaseAlreadyOpenException {
//       // it is fine if db is already open
//     }
//   }

//   Database _getDatabaseOrThrow() {
//     final db = _db;

//     if (db == null) throw DatabaseIsNotOpenException();

//     return db;
//   }
// }
