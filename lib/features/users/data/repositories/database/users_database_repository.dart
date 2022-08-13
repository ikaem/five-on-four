import 'package:five_on_four/features/users/data/repositories/database/queries.dart';
import 'package:five_on_four/features/users/data/repositories/users_repository.dart';
import 'package:five_on_four/features/users/doman/models/user.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';

class UsersDatabaseRepository implements UsersRepository {
  final Db _db;

  UsersDatabaseRepository(this._db);

  @override
  Future<List<User>> searchMany(String nickname) async {
    // TODO: implement searchMany
    // throw UnimplementedError();

    // devService.log("loging in the repo: $nickname");

    final dbConnection = await _db.getConnection;

// TODO example here https://stackoverflow.com/questions/55905892/how-to-query-the-sqflite-database-using-the-like-statement-and-the-or-sql-wi
    final usersRows = await dbConnection
        // .rawQuery(UsersQueries.searchUsersByNickname(), ["%$nickname%"]);
        .rawQuery(UsersQueries.searchUsersByNickname(), ["%$nickname%"]);

    final users = transformUsersRowsToUsers(usersRows);
    return users;
  }
}

List<User> transformUsersRowsToUsers(List<Map<String, Object?>> usersRows) {
  if (usersRows.isEmpty) return [];

  List<User> users = usersRows.map((row) {
    return User.fromDbRow(row);
  }).toList();

  return users;
}
