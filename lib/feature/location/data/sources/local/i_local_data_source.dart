import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';

abstract interface class ILocalDataSource {
  Future<Either<Failure, void>> saveLocationLocally(
      double latitude, double longitude);
  Future<Either<Failure, Unit>> startLocationTracking();

  void stopLocationTracking();
}
