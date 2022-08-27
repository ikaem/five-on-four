import 'package:five_on_four/features/users/application/services/users_service.dart';
import 'package:five_on_four/features/users/data/repositories/users_repository_provider.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';
import 'package:five_on_four/services/database/db.dart';
import 'package:five_on_four/services/dev/dev_service.dart';

// TODO could we make a class singleton to extend from

class UsersController {
  final UsersService _usersService = UsersService(
    // TODO database should be initialiazed here already
    usersRepositoryProvider: UsersRepositoryProvider.database(Db()),
  );

  // singletong
  static final UsersController _instance = UsersController._internal();
  factory UsersController() {
    return _instance;
  }
  UsersController._internal();

  Future<List<User>> searchUsersByNickname(String nickname) async {
    final users = await _usersService.searchUsers(nickname);

    return users;
  }
}
