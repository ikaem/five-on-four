import 'package:five_on_four/features/users/data/repositories/users_repository.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';

class UsersService {
  late UsersRepository _usersRepositoryProvider;

  UsersService({
    required UsersRepository usersRepositoryProvider,
  }) {
    _usersRepositoryProvider = usersRepositoryProvider;
  }

  Future<List<User>> searchUsers(String nickname) async {
    final users = _usersRepositoryProvider.searchMany(nickname);

    return users;
  }
}
