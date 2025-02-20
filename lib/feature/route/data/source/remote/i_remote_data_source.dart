import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/auth/data/models/user_model.dart';
import 'package:flutter_mapa/feature/route/data/models/route_model.dart';

abstract interface class IRemoteDataSource {
  Future<Either<Failure, Unit>> joinRoute(String routeId, UserModel user);

  Future<Either<Failure, Unit>> createRoute(RouteModel model);
}
