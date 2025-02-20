import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/data/model/location_model.dart';

abstract interface class IRemoteDataSource {
  Future<Either<Failure, Unit>> saveLocationToServer(
      String routeId, List<LocationModel> locations);
}
