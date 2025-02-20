import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/domain/repositories/i_location_repostiroy.dart';

class SaveLocationLocallyUsecase {
  ILocationRepository repository;

  SaveLocationLocallyUsecase(this.repository);

  Future<Either<Failure, void>> call(double latitude, double longitude) async {
    return await repository.saveLocationLocally(latitude, longitude);
  }
}
