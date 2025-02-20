import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:flutter_mapa/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_mapa/feature/route/presentation/controllers/route_controller.dart';
import 'package:get/get.dart';

class RutaScreen extends StatelessWidget {
  final String codigoRuta = Get.parameters['codigo'] as String;
  final bool esGuia = true;

  RutaScreen({super.key});

  final RouteController rutaController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('Código de la ruta: $codigoRuta');

    print('Es guía: $esGuia');

    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta: $codigoRuta'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ParticipantesList(
                codigoRuta: codigoRuta), // Lista de participantes
          ),
          if (esGuia) // Mostrar botón solo si es el guía
            ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para comenzar la ruta
                  comenzarRuta(codigoRuta);
                },
                child: Text('Comenzar Ruta'),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Future<void> comenzarRuta(String codigoRuta) async {
    try {
      await FirebaseFirestore.instance
          .collection('rutas')
          .doc(codigoRuta)
          .update({
        'estado': 'en_progreso', // Cambiar el estado de la ruta
      });

      rutaController.iniciarCapturaDePosicion();

      Get.snackbar('Éxito', 'La ruta ha comenzado');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo comenzar la ruta: $e');
    }
  }
}

class ParticipantesList extends StatelessWidget {
  final String codigoRuta;

  const ParticipantesList({required this.codigoRuta, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return StreamBuilder<DocumentSnapshot>(
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

        // Redirigir si el estado es "en_progreso"
        if (estado == 'en_progreso') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigationServices.navigateWithPush(Routes.LOADING,
                queryParams: {'codigo': codigoRuta});
          });
        }

        final participantes =
            rutaData['participantes'] as Map<String, dynamic>? ?? {};

        return ListView.builder(
          itemCount: participantes.length,
          itemBuilder: (context, index) {
            final participante =
                participantes.values.elementAt(index) as Map<String, dynamic>;

            return ListTile(
              title: Text(participante['id'] ?? 'Anonimo'),
              // subtitle: Text(participante['email'] ?? ''),
            );
          },
        );
      },
    );
  }
}
