import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/route/domain/repositories/i_route_repository.dart';

class FinishRouteUsecase {
  final IRouteRepository _repository;

  FinishRouteUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String routeId, String userId,
      List<Map<String, dynamic>> positions) async {
    return await _repository.finishRoute(routeId, userId, positions);
  }
}
