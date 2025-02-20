import 'package:flutter_mapa/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_mapa/feature/auth/data/sources/remote/auth_data_source.dart';
import 'package:flutter_mapa/feature/auth/data/sources/remote/firebase_auth_data_source.dart';
import 'package:flutter_mapa/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_mapa/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

void setupAuthDependencies() {
  // Fuente de datos de autenticación (Firebase)
  Get.lazyPut<AuthDataSource>(
    () => FirebaseAuthDataSource(),
  );

  // Repositorio de autenticación
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(
      Get.find<AuthDataSource>(),
    ),
  );

  // Controlador de autenticación
  Get.lazyPut<AuthController>(
    () => AuthController(
      Get.find<AuthRepository>(),
    ),
  );
}
