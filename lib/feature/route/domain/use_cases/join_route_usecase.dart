import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/route/domain/repositories/i_route_repository.dart';

class JoinRouteUsecase {
  final IRouteRepository _repository;

  JoinRouteUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String code, UserEntity user) async {
    return await _repository.joinRoute(code, user);
  }
}
