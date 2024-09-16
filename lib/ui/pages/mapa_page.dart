import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_mapa/ui/helpers/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/ubicacion_controller.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  List listOfPoints = [];

  List<LatLng> points = [];

  //funtion para consumir api

  getCoordinates() async {
    try {
      var response = await http.get(getRouterURL('', ''));
      print('Response: $response');

      setState(() {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);

          listOfPoints = data['decoded_points'];
          print('List of points: $listOfPoints');
          points =
              listOfPoints.map((point) => LatLng(point[1], point[0])).toList();
            print('Points: $points');
        } else {
          print('Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    UbicacionController ubicacionController = Get.find();

    return Scaffold(
      body: Center(
        child: Obx(() => _crearMapa(ubicacionController)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCoordinates();
        },
        child: const Icon(Icons.route),
      ),
    );
  }

  Widget _crearMapa(UbicacionController ubicacionController) {
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
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
