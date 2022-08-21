import 'package:five_on_four/features/authentication/data/repositories/auth_repository.dart';
import 'package:five_on_four/features/authentication/data/repositories/database/auth_database_repository.dart';
import 'package:five_on_four/features/authentication/domain/models.dart';
import 'package:five_on_four/services/database/db.dart';

class AuthRepositoryProvider implements AuthRepository {
  late final AuthRepository _authRepository;

  AuthRepositoryProvider(this._authRepository);

  AuthRepositoryProvider.database(Db db) {
    _authRepository = AuthDatabaseRepository(db);
  }

  @override
  Future<Auth> session() async {
    final auth = _authRepository.login();

    return auth;
  }

  @override
  Future<Auth> login() async {
    final auth = _authRepository.login();

    return auth;
  }
}
