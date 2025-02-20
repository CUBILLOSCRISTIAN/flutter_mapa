import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/data/model/location_model.dart';
import 'package:flutter_mapa/feature/location/data/sources/local/i_local_data_source.dart';
import 'package:flutter_mapa/feature/location/data/sources/remote/i_remote_data_source.dart';
import 'package:flutter_mapa/feature/location/domain/entities/location_entity.dart';
import 'package:flutter_mapa/feature/location/domain/repositories/i_location_repostiroy.dart';

class LocationRepositoryImpl implements ILocationRepository {
  ILocalDataSource localDataSource;
  IRemoteDataSource remoteDataSource;

  LocationRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, void>> saveLocationLocally(
      double latitude, double longitude) {
    return localDataSource.saveLocationLocally(latitude, longitude);
  }

  @override
  Future<Either<Failure, Unit>> saveLocationToServer(
      String routeId, List<LocationEntity> locations) {
    // Convert List<LocationEntity> to List<LocationModel>
    final locationModels =
        locations.map((e) => LocationModel.fromEntity(e)).toList();

    return remoteDataSource.saveLocationToServer(routeId, locationModels);
  }

  @override
  Future<Either<Failure, Unit>> startSaveLocationLocally() async {
    return await localDataSource.startLocationTracking();

    
  }
}
