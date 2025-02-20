import 'package:flutter_mapa/feature/auth/data/sources/remote/auth_data_source.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authProvider;

  AuthRepositoryImpl(this._authProvider);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      String email, String password, UserRole role) async {
    await _authProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
      role: role,
    );
  }

  @override
  Future<void> signOut() async {
    await _authProvider.signOut();
  }

  @override
  Future<bool> isSignedIn() async {
    return _authProvider.isSignedIn();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _authProvider.getCurrentUser();
  }

  // // Convertir Firebase User a nuestra entidad User
  // UserEntity _mapFirebaseUser(User? user) {
  //   if (user == null) throw Exception('User is null');
  //   return UserEntity(id: user.uid, email: user.email ?? '');
  // }
}
