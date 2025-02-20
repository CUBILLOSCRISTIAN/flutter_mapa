import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required UserRole role,
  });
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<UserEntity?> getCurrentUser();
}
