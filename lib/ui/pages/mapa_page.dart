import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapa/ui/controllers/ubicacion_controller.dart';
import 'package:flutter_mapa/ui/widgets/card_info_main.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

// import 'package:flutter_mapa/config/controllers/graph_controller.dart';
// import 'package:flutter_mapa/domain/models/Graph/node.dart' as domain;

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocationController ubicacionController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Page'),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Obx(() => _crearMapa(ubicacionController)),
          ),
          Positioned(
            bottom: context.height * 0.05,
            left: 0,
            right: 0,
            child: Container(
              height: context.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                    Colors.black,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: [0.0, 0.1, 0.9, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: context.height * 0.05,
            left: 0 + 10,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardInfoMain(),
                  SizedBox(width: 10),
                  CardInfoMain(),
                  SizedBox(width: 10),
                  CardInfoMain(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // calculateRoute(
          //   LatLng(-74.851285258320004, 11.02109875295),
          //   LatLng(-74.851285300064646, 11.02109875300742),
          // );
        },
        child: const Icon(Icons.search_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _crearMapa(
    LocationController ubicacionController,
  ) {
    if (!ubicacionController.existeUbicacion.value) {
      return const Text('Ubicando...');
    }

    final ubicacion = ubicacionController.ubicacion.value;

    final options = MapOptions(
      initialCenter: LatLng(ubicacion.latitude, ubicacion.longitude),
      minZoom: 10,
      maxZoom: 19,
      initialZoom: 19,
    );

    return FlutterMap(
      options: options,
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          maxZoom: 19,
        ),
        MarkerLayer(markers: [
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(ubicacion.latitude, ubicacion.longitude),
            child: const Icon(
              Icons.person,
              size: 30.0,
              color: Colors.red,
            ),
          ),
        ]),
      ],
    );
  }
}
