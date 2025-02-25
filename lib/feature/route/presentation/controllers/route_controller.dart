import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/route/config/routes/routes_route.dart';
import 'package:flutter_mapa/feature/route/domain/entity/route.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/create_route_usecase.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/finish_route_usecase.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/join_route_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  final CreateRouteUsecase createRouteUsecase;
  final JoinRouteUsecase joinRouteUsecase;
  final FinishRouteUsecase finishRouteUsecase;

  RouteController({
    required this.createRouteUsecase,
    required this.joinRouteUsecase,
    required this.finishRouteUsecase,
  });

  final codigoController = TextEditingController();

  Timer? _timer;
  final ruta = RouteEntity(id: '', codigo: '').obs;
  final RxString codigoSala = ''.obs;

  final List<Map<String, dynamic>> posiciones = [];

  void agregarPosicion(double latitud, double longitud) {
    posiciones.add({
      'latitud': latitud,
      'longitud': longitud,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> crearRuta() async {
    final codigo = generarCodigoAleatorio();
    codigoSala.value = codigo;
    final nuevaRuta = RouteEntity(id: codigo, codigo: codigo);

    var result = await createRouteUsecase(nuevaRuta);

    result.fold((fail) => Get.snackbar("Ups algo falló", fail.message),
        (result) {
      ruta.value = nuevaRuta;
      Get.snackbar('Éxito', 'Ruta creada correctamente');
      NavigationServices.navigateWithPush(
        RoutesRoute.WAITING_ROOM,
        queryParams: {'codeRoom': codigo},
      );
    });
  }

  String generarCodigoAleatorio() {
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
        6, (_) => caracteres[Random().nextInt(caracteres.length)]).join();
  }

  Future<void> unirseARuta({
    required UserEntity user,
  }) async {
    final codigoRuta = codigoController.text.trim();
    if (codigoRuta.isEmpty) {
      Get.snackbar('Error', 'Por favor ingresa un código de ruta');
      return;
    }

    try {
      // Verificar si la ruta existe
      await joinRouteUsecase(codigoRuta, user);
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al unirse a la ruta: $e');
    }
  }

  Future<Map<String, dynamic>> obtenerDatosUsuario() {
    // Método para obtener los datos del usuario actual
    return Future.value({
      'idVisitante': 'Juan Pérez',
      'locations': [],
    });
  }

  Future<void> finalizarRuta(
      {required String rutaId, required String visitanteId}) async {
    // Enviar datos a Firestore
    await finishRouteUsecase(rutaId, visitanteId, posiciones);

    detenerCapturaDePosicion();

    // Limpiar el array
    posiciones.clear();
  }

  void iniciarCapturaDePosicion() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      final position = await Geolocator.getCurrentPosition();
      debugPrint(
          'Posición actual: ${position.latitude}, ${position.longitude}');
      agregarPosicion(position.latitude, position.longitude);
    });
  }

  void detenerCapturaDePosicion() {
    _timer?.cancel();
  }
}
