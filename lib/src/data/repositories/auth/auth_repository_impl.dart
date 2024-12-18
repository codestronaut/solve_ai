import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/utils/result.dart';
import 'auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required FirebaseAuth authService})
      : _authService = authService;

  final FirebaseAuth _authService;
  final _log = Logger('AuthRepository');

  @override
  Future<Result<UserCredential>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      final credential = await _authService.signInWithProvider(appleProvider);
      return Result.ok(credential);
    } on FirebaseAuthException catch (e) {
      _log.warning(e.message);
      return Result.error(e);
    } on Exception catch (e) {
      _log.warning(e.toString());
      return Result.error(e);
    }
  }

  @override
  Future<Result<UserCredential>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = await _authService.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        ),
      );
      return Result.ok(credential);
    } on FirebaseAuthException catch (e) {
      _log.warning(e.message);
      return Result.error(e);
    } on Exception catch (e) {
      _log.warning(e.toString());
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> signOut() async {
    try {
      await _authService.signOut();
      return Result.ok(true);
    } on FirebaseAuthException catch (e) {
      _log.warning(e.message);
      return Result.error(e);
    } on Exception catch (e) {
      _log.warning(e.toString());
      return Result.error(e);
    }
  }

  @override
  User? getCurrentUser() => _authService.currentUser;
}
