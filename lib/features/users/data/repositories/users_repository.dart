import 'package:five_on_four/features/users/domain/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> searchMany(String nickname);
}
