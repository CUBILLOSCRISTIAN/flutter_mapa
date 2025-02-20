import 'package:flutter_mapa/feature/route/data/repositories/route_repository_impl.dart';
import 'package:flutter_mapa/feature/route/data/source/remote/firebase_data_source.dart';
import 'package:flutter_mapa/feature/route/data/source/remote/i_remote_data_source.dart';
import 'package:flutter_mapa/feature/route/domain/repositories/i_route_repository.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/create_route_usecase.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/join_route_usecase.dart';
import 'package:flutter_mapa/feature/route/presentation/controllers/route_controller.dart';
import 'package:get/get.dart';

void setupRouteDependencies() {
  // Fuente de datos remota de rutas (Firebase)
  Get.lazyPut<IRemoteDataSource>(
    () => FirebaseDataSource(),
  );

  // Repositorio de rutas
  Get.lazyPut<IRouteRepository>(
    () => RouteRepositoryImpl(
      Get.find<IRemoteDataSource>(),
    ),
  );

  // Caso de uso para crear rutas
  Get.lazyPut<CreateRouteUsecase>(
    () => CreateRouteUsecase(
      Get.find<IRouteRepository>(),
    ),
  );

  // Caso de uso para unirse a rutas
  Get.lazyPut<JoinRouteUsecase>(
    () => JoinRouteUsecase(
      Get.find<IRouteRepository>(),
    ),
  );

  // Controlador de rutas
  Get.lazyPut<RouteController>(
    () => RouteController(
      createRouteUsecase: Get.find<CreateRouteUsecase>(),
      joinRouteUsecase: Get.find<JoinRouteUsecase>(),
    ),
  );
}
