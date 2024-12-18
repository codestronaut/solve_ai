import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/utils/result.dart';

abstract class AuthRepository {
  Future<Result<UserCredential>> signInWithApple();
  Future<Result<UserCredential>> signInWithGoogle();
  Result<User> getCurrentUser();
}
