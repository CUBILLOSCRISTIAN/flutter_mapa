import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/domain/entities/location_entity.dart';

abstract interface class ILocationRepository {
  Future<Either<Failure, Unit>> saveLocationToServer(
      String routeId, List<LocationEntity> locations);

  Future<Either<Failure, void>> saveLocationLocally(
      double latitude, double longitude);

  Future<Either<Failure, Unit>> startSaveLocationLocally();
}
