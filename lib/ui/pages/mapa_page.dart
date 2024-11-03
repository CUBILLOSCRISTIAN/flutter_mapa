import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'package:flutter_mapa/domain/models/Graph/node.dart' as domain;
import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/ui/controllers/graph_controller.dart';
import 'package:flutter_mapa/ui/controllers/pois_controller.dart';
import 'package:flutter_mapa/ui/controllers/ubicacion_controller.dart';
import 'package:flutter_mapa/ui/delegates/search_delegate.dart';
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
  //Lista de puntos para los POIs
  List listOfPOIs = [];
  List<LatLng> markersList = [];

  //Lista de puntos para el camino más corto
  List<domain.Node> listOfPointsOfPath = [];
  List pointsOfPath = [];
  List<LatLng> path = [];
  PoisController poisController = Get.find();

  @override
  void initState() {
    super.initState();
    // _loadPOIs();
  }

  //

  @override
  Widget build(BuildContext context) {
    LocationController ubicacionController = Get.find();
    GraphController graphController = Get.find();

    Future<void> _loadPOIs(poi) async {
      listOfPOIs.clear();
      pointsOfPath.clear();
      path.clear();
      listOfPointsOfPath.clear();

      listOfPOIs.add(LatLng(poi.latitude, poi.longitude));
      listOfPointsOfPath = graphController.findShortestPath(
          ubicacionController.ubicacion.value,
          LatLng(poi.latitude, poi.longitude));
      listOfPointsOfPath.forEach((element) {
        pointsOfPath.add(LatLng(
            element.coordinates.latitude, element.coordinates.longitude));
      });

      setState(() {
        path = List<LatLng>.from(pointsOfPath);
        markersList = List<LatLng>.from(listOfPOIs);
      });
    }

    return Scaffold(
      body: Center(
        child: Obx(() => _crearMapa(ubicacionController)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch<PointOfInterest?>(
            context: context,
            delegate: SearchDelegateClass(
              searchPOI: poisController.searchPOIs,
            ),
          ).then((poi) {
            if (poi != null) {
              _loadPOIs(poi);
            }
          });
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
        MarkerLayer(markers: [
          for (var point in markersList)
            Marker(
              width: 40.0,
              height: 40.0,
              point: point,
              child: const Icon(
                Icons.location_on,
                size: 30.0,
                color: Colors.red,
              ),
            ),
        ]),
        PolylineLayer(
          polylines: [
            Polyline(
              points: path,
              strokeWidth: 4,
              color: Colors.deepPurple[600]!,
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
