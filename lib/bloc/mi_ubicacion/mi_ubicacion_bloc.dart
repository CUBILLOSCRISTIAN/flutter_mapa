import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState(ubicacion: LatLng(0, 0))) {
    on<OnUbicacionCambio>((event, emit) {
      emit(state.copyWith(ubicacion: event.ubicacion, existeUbicacion: true));
    });
  }
  StreamSubscription<Position>? _positionSubscription;

  void iniciarSeguimiento() {
    //* Activar el seguimiento de la ubicación del usuario
    const locationSettings = LocationSettings(
      accuracy:
          LocationAccuracy.high, //* Precisión alta para el GPS (más batería)
      distanceFilter: 5, //* Cada cuántos metros se actualiza la ubicación
    );

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    if (event is OnUbicacionCambio) {
      print(event);
      yield state.copyWith(ubicacion: event.ubicacion, existeUbicacion: true);
    }
  }
}
