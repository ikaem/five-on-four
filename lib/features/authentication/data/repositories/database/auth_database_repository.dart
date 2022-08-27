import 'package:five_on_four/features/authentication/data/repositories/auth_repository.dart';
import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/services/database/db.dart';

class AuthDatabaseRepository implements AuthRepository {
  final Db _db;

  AuthDatabaseRepository(this._db);

  @override
  Future<Auth> session() async {
    final dbConnection = await _db.getConnection;

    final auth = Auth.fromDbRow({
      "fake": {"moreTest": "Fake data"}
    });

    return Future.value(auth);
  }

  @override
  Future<Auth> login() async {
    final dbConnection = await _db.getConnection;

    final auth = Auth.fromDbRow({
      "fake": {"moreTest": "Fake data"}
    });

    return Future.value(auth);
  }
}
