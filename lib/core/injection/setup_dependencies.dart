import 'package:flutter_mapa/feature/auth/config/injection/setup_auth_dependencies.dart';
import 'package:flutter_mapa/feature/route/config/injection/setup_route_dependencies.dart';

void setupDependencies() {
  // Inicializa las dependencias de autenticación
  setupAuthDependencies();

  setupRouteDependencies();
}
