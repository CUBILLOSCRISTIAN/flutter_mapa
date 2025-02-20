import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/auth/data/models/user_model.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/route/data/models/route_model.dart';
import 'package:flutter_mapa/feature/route/data/source/remote/i_remote_data_source.dart';
import 'package:flutter_mapa/feature/route/domain/entity/route.dart';
import 'package:flutter_mapa/feature/route/domain/repositories/i_route_repository.dart';

class RouteRepositoryImpl implements IRouteRepository {
  final IRemoteDataSource _remoteDataSource;

  RouteRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Unit>> createRoute(RouteEntity entity) async {
    //Convertir de modelo a entidad
    RouteModel model = RouteModel.toEntity(entity);

    //Llamar al metodo del data source
    return await _remoteDataSource.createRoute(model);
  }

  @override
  Future<Either<Failure, Unit>> joinRoute(String code, UserEntity user) async {
    UserModel userModel = UserModel.toEntity(user);

    return await _remoteDataSource.joinRoute(code, userModel);
  }
}
