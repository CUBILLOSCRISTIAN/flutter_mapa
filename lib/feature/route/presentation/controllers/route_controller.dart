import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:flutter_mapa/feature/route/domain/entity/route.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/create_route_usecase.dart';
import 'package:flutter_mapa/feature/route/domain/use_cases/join_route_usecase.dart';
import 'package:flutter_mapa/ui/screens/unirse_a_ruta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  //! TODO DESACOPLAR ESTE CONTROLADOR DE FIREBASE

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CreateRouteUsecase createRouteUsecase;
  final JoinRouteUsecase joinRouteUsecase;

  RouteController({
    required this.createRouteUsecase,
    required this.joinRouteUsecase,
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

    await _firestore.collection('rutas').doc(codigo).set(
          nuevaRuta.toMap(),
        );
    await _firestore
        .collection('rutas')
        .doc(codigo)
        .collection('participantes')
        .add({});
    ruta.value = nuevaRuta;

    Get.snackbar('Éxito', 'Ruta creada correctamente');

    // Get.toNamed(Routes.detailRoute,
    //     parameters: {'codigo': codigo, 'esGuia': true.toString()});
  }

  String generarCodigoAleatorio() {
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
        6, (_) => caracteres[Random().nextInt(caracteres.length)]).join();
  }

  Future<void> unirseARuta({
    required Usuario user,
  }) async {
    final codigoRuta = codigoController.text.trim();
    if (codigoRuta.isEmpty) {
      Get.snackbar('Error', 'Por favor ingresa un código de ruta');
      return;
    }

    try {
      // Verificar si la ruta existe
      final snapshot = await FirebaseFirestore.instance
          .collection('rutas')
          .doc(codigoRuta)
          .get();

      if (snapshot.exists) {
        // Obtener los datos del usuario actual

        await FirebaseFirestore.instance
            .collection('rutas')
            .doc(codigoRuta)
            .set({
          'participantes': {user.id: user.toMap()}
        }, SetOptions(merge: true));

        // Verificar si el usuario es el guía
        final esGuia = true; // await esGuia(codigoRuta);

        // Navegar a la pantalla de la ruta
        // NavigationServices.navigateWithPush(Routes.detailRoute,
        //     queryParams: {'codigo': codigoRuta, 'esGuia': esGuia.toString()});
      } else {
        Get.snackbar('Error', 'Ruta no encontrada');
      }
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
    await _firestore.collection('rutas').doc(rutaId).update({
      'participantes.$visitanteId.posiciones': posiciones,
    });

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
