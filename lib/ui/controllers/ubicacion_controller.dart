import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';


class UbicacionController extends GetxController {
  var siguiendo = true.obs;
  var existeUbicacion = false.obs;
  var ubicacion = const LatLng(0, 0).obs;

  StreamSubscription<Position>? _positionSubscription;

  @override
  void onInit() {
    super.onInit();
    iniciarSeguimiento();
  }

  void iniciarSeguimiento() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);
      ubicacion.value = nuevaUbicacion;
      existeUbicacion.value = true;
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  @override
  void onClose() {
    cancelarSeguimiento();
    super.onClose();
  }
}