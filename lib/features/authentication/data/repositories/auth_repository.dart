import 'package:five_on_four/features/authentication/domain/models.dart';

abstract class AuthRepository {
  // this will just check if we have a valid session
  Future<Auth> session();
  // TODO this will need some arguments
  Future<Auth> login();
}
