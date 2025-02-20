import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/route/domain/entity/route.dart';

abstract interface class IRouteRepository {
  Future<Either<Failure, Unit>> joinRoute(String code, UserEntity user);
  Future<Either<Failure, Unit>> createRoute(RouteEntity entity);
}
