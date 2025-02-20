import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_mapa/feature/route/presentation/controllers/route_controller.dart';
import 'package:flutter_mapa/ui/screens/unirse_a_ruta.dart';
import 'package:get/get.dart';

class RutaEnprogreso extends StatelessWidget {
  final String codigoRuta = Get.parameters['codigo']!;

  RutaEnprogreso({super.key});
  final RouteController controller = Get.find();

  final AuthController authController = Get.find();
  // Método que se ejecutará al inicializar la pantalla
  void _iniciarMetodo() {
    // Aquí implementa la lógica que deseas ejecutar al iniciar
    controller.iniciarCapturaDePosicion();
    print("Método de inicio ejecutado para la ruta: $codigoRuta");
  }

  // Método que se ejecutará cuando la ruta esté finalizada
  void _finalizarMetodo() {
    // Aquí implementa la lógica que deseas ejecutar al finalizar
    controller.detenerCapturaDePosicion();
    var user = FirebaseAuth.instance.currentUser;

    // Lógica para finalizar la ruta
    controller.finalizarRuta(
        rutaId: codigoRuta, visitanteId: user?.uid ?? '123');
    print("Método de finalización ejecutado para la ruta: $codigoRuta");
  }

  Future<Usuario> obtenerDatosUsuario() async {
    final user = FirebaseAuth.instance.currentUser!;
    return Usuario(
      id: user.uid,
      nombre: user.displayName ?? user.email!,
      locations: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ejecutar el método de inicio al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _iniciarMetodo();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta en Progreso: $codigoRuta'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rutas')
            .doc(codigoRuta)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No se encontró la ruta'));
          }

          final rutaData = snapshot.data!.data() as Map<String, dynamic>;
          final estado = rutaData['estado'] as String? ?? '';

          // Si el estado es "finalizado", redirigir y ejecutar el método de finalización
          if (estado == 'finalizado') {
            Get.snackbar('Ruta finalizada', 'Por el guia');

            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (authController.user?.role == UserRole.participant) {
                await controller.finalizarRuta(
                    rutaId: codigoRuta,
                    visitanteId:
                        FirebaseAuth.instance.currentUser?.uid ?? '123');
                controller.detenerCapturaDePosicion();
              }

              Get.toNamed(Routes.HOME_PAGE); // Redirigir
            });
          }

          return Column(
            children: [
              Center(
                child: Text('Estado actual de la ruta: $estado'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para comenzar la ruta
                    finalizarMetodo(codigoRuta);
                  },
                  child: Text('Finliaz Ruta'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> finalizarMetodo(String codigoRuta) async {
    try {
      await FirebaseFirestore.instance
          .collection('rutas')
          .doc(codigoRuta)
          .update({
        'estado': 'finalizado', // Cambiar el estado de la ruta
      });
      // controller.detenerCapturaDePosicion();
      // controller.finalizarRuta(
      //     rutaId: codigoRuta,
      //     visitanteId: FirebaseAuth.instance.currentUser!.uid);

      Get.snackbar('Éxito', 'La ruta ha finalizado');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo comenzar la ruta: $e');
    }
  }
}
