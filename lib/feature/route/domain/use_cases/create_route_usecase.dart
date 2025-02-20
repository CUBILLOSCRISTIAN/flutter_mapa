import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/route/domain/entity/route.dart';
import 'package:flutter_mapa/feature/route/domain/repositories/i_route_repository.dart';

class CreateRouteUsecase {
  final IRouteRepository _repository;

  CreateRouteUsecase(this._repository);

  Future<Either<Failure, Unit>> call(RouteEntity entity) async {
    return await _repository.createRoute(entity);
  }
}
