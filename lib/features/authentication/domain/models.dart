import 'package:five_on_four/features/users/domain/models/user.dart';

class Auth {
  // TODO at this point just providional fields to put something in here
  late final bool isLoggedIn;
  late final bool isEmailConfirmed;
  late final bool isTwoFactorEnabled;
  late final User user;

  // TODO not suer if should have named constructor here
  Auth.fromDbRow(Map<String, Object?> row) {
    // TODO need to get data
    isLoggedIn = true;
    isEmailConfirmed = true;
    isTwoFactorEnabled = false;
    user = User(id: 1, nickname: "Zidane");
  }
}
