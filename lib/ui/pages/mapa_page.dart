import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_mapa/config/controllers/graph_controller.dart';
import 'package:flutter_mapa/ui/delegates/search_delegate.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart' as domain;

import '../../config/controllers/ubicacion_controller.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  List listOfPoints = [];

  List<LatLng> points = [];

  @override
  Widget build(BuildContext context) {
    LocationController ubicacionController = Get.find();
    GraphController graphController = Get.find();

    return Scaffold(
      body: Center(
        child: Obx(() => _crearMapa(ubicacionController)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // List<domain.Node> listPath = graphController.findShortestPath();
          // listPath.forEach((element) {
          //   listOfPoints.add(LatLng(element.coordinates.latitude, element.coordinates.longitude));
          // });
          // debugPrint('Shortest path: ${graphController.findShortestPath()}');
          // setState(() {
          //   points = List<LatLng>.from(listOfPoints);
          // });
          showSearch(context: context, delegate: SearchDelegateClass());
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
        CurrentLocationLayer(
          style: LocationMarkerStyle(
            marker: const DefaultLocationMarker(
              color: Colors.green,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            markerSize: const Size.square(40),
            accuracyCircleColor: Colors.green.withOpacity(0.1),
            headingSectorColor: Colors.green.withOpacity(0.8),
            headingSectorRadius: 120,
          ),
          moveAnimationDuration: Duration.zero,
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: points,
              strokeWidth: 4,
              color: Colors.red,
            ),
          ],
        ),
        const SimpleAttributionWidget(
          source: Text('OpenStreetMap contributors'),
        ),
      ],
    );
  }
}
