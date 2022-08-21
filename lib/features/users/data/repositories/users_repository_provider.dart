import 'package:five_on_four/features/users/data/repositories/database/users_database_repository.dart';
import 'package:five_on_four/features/users/data/repositories/users_repository.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';
import 'package:five_on_four/services/database/db.dart';

class UsersRepositoryProvider implements UsersRepository {
  late final UsersRepository _usersRepository;

  UsersRepositoryProvider(this._usersRepository);

  UsersRepositoryProvider.database(Db db) {
    // we now want to provide database to the users database repositroy
    _usersRepository = UsersDatabaseRepository(db);
  }

  @override
  Future<List<User>> searchMany(String nickname) async {
    final many = await _usersRepository.searchMany(nickname);

    return many;
    //
  }
}
