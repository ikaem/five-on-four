import 'package:five_on_four/features/authentication/data/repositories/auth_repository.dart';
import 'package:five_on_four/features/authentication/domain/models.dart';

class AuthService {
  late AuthRepository _authRepositoryProvider;

  AuthService({required AuthRepository authRepositoryProvider}) {
    _authRepositoryProvider = authRepositoryProvider;
  }

  Future<Auth> sessionAuth() {
    final auth = _authRepositoryProvider.login();
    return auth;
  }

// TODO will probably need some arguments here
  Future<Auth> loginAuth() {
    final auth = _authRepositoryProvider.login();
    return auth;
  }
}
