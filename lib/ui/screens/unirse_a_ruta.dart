import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_mapa/feature/location/domain/entities/location_entity.dart';
import 'package:flutter_mapa/feature/route/presentation/controllers/route_controller.dart';
import 'package:get/get.dart';

class UnirseARutaScreen extends StatelessWidget {
  // final TextEditingController codigoController = TextEditingController();
  final RouteController rutaController = Get.find();

  final AuthController authController = Get.find();

  UnirseARutaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unirse a Ruta Guiada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => Text(
                  'Hello ${authController.user?.email} tienes permiso de  ${authController.user?.role}'),
            ),
            Obx(() => (authController.user?.role == UserRole.guide ||
                    authController.user?.role == UserRole.admin)
                ? ElevatedButton(
                    onPressed: () => rutaController.crearRuta(),
                    child: Text("Crear Ruta xd"))
                : Container()),
            TextField(
              controller: rutaController.codigoController,
              decoration: InputDecoration(
                labelText: 'Código de la Ruta',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: unirseARuta,
              child: Text('Unirse a Ruta'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> unirseARuta() async {
    final codigoRuta = rutaController.codigoController.text.trim();
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
        final usuario = await obtenerDatosUsuario();

        await FirebaseFirestore.instance
            .collection('rutas')
            .doc(codigoRuta)
            .set({
          'participantes': {usuario.id: usuario.toMap()}
        }, SetOptions(merge: true));

        // Verificar si el usuario es el guía
        final esGuia = true; // await esGuia(codigoRuta);

        // Navegar a la pantalla de la ruta
        NavigationServices.navigateWithPush(Routes.LOADING,
            queryParams: {'codigo': codigoRuta, 'esGuia': esGuia.toString()});
      } else {
        Get.snackbar('Error', 'Ruta no encontrada');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al unirse a la ruta: $e');
    }
  }

  Future<Usuario> obtenerDatosUsuario() async {
    final user = FirebaseAuth.instance.currentUser!;
    return Usuario(
      id: user.uid,
      nombre: user.displayName ?? user.email!,
      locations: [],
    );
  }

  Future<bool> esGuia(String codigoRuta) async {
    // final user = FirebaseAuth.instance.currentUser!;
    final snapshot = await FirebaseFirestore.instance
        .collection('rutas')
        .doc(codigoRuta)
        .get();

    if (snapshot.exists) {
      final rutaData = snapshot.data() as Map<String, dynamic>;
      final idGuia = rutaData['lider'];
      return idGuia;
    }

    return false;
  }
}

class Usuario {
  final String id;
  final String nombre;
  final List<LocationEntity> locations;

  Usuario({required this.id, required this.nombre, required this.locations});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': locations,
    };
  }
}
