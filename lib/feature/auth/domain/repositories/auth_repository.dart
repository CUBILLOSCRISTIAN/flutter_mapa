import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    UserRole role,
  );
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<UserEntity?> getCurrentUser();
}
