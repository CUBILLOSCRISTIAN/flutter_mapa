import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/domain/entities/location_entity.dart';
import 'package:flutter_mapa/feature/location/domain/repositories/i_location_repostiroy.dart';

class SaveLocationToServerUsecase {
  ILocationRepository repository;

  SaveLocationToServerUsecase(this.repository);

  Future<Either<Failure, void>> call(
      String routeId, List<LocationEntity> locations) async {
    return await repository.saveLocationToServer(routeId, locations);
  }
}
