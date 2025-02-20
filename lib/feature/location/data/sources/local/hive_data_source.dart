import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/data/model/location_model.dart';
import 'package:flutter_mapa/feature/location/data/sources/local/i_local_data_source.dart';
import 'package:flutter_mapa/ui/controllers/ubicacion_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveDataSource implements ILocalDataSource {
  final Box<LocationModel> locationBox =
      Hive.box<LocationModel>('locationsBox');

  Timer? _timer;

  @override
  Future<Either<Failure, void>> saveLocationLocally(
      double latitude, double longitude) async {
    final location = LocationModel(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );
    try {
      locationBox.add(location);
      return Right(null);
    } catch (_) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> startLocationTracking() async {
    try {
      _timer = Timer.periodic(
        const Duration(seconds: 10),
        (timer) async {
          final position = Get.find<LocationController>().ubicacion;

          await saveLocationLocally(
              position.value.latitude, position.value.latitude);
        },
      );
      return Right(unit);
    } catch (_) {
      return Left(TrackingFailure());
    }
  }

  @override
  void stopLocationTracking() {
    _timer?.cancel();
  }
}
