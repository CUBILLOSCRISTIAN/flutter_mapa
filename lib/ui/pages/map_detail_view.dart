import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gpx/gpx.dart';

class MapDetailView extends StatelessWidget {
  const MapDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Positioned.fill(child: MbtilesMap())],
      ),
    );
  }
}

class MbtilesMap extends StatefulWidget {
  const MbtilesMap({super.key});

  @override
  _MbtilesMapState createState() => _MbtilesMapState();
}

class _MbtilesMapState extends State<MbtilesMap> {
  late String _mbtilesPath; // Ruta al archivo MBTiles
  bool _isLoading = true; // Bandera para controlar si los datos están cargando

  List<LatLng> _routePoints = []; // Lista de puntos para la ruta

  @override
  void initState() {
    super.initState();
    _loadMbtiles();
    _loadGpxRoute(); // Cargar la ruta GPX
  }

  Future<void> _loadMbtiles() async {
    try {
      // Copiar el archivo MBTiles desde assets a la carpeta temporal
      final directory = await getTemporaryDirectory();
      final tempPath = '${directory.path}/map.mbtiles';

      final data =
          await DefaultAssetBundle.of(context).load('assets/campus_to.mbtiles');
      final bytes = data.buffer.asUint8List();
      await File(tempPath).writeAsBytes(bytes);

      setState(() {
        _mbtilesPath = tempPath;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al cargar el archivo MBTiles: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadGpxRoute() async {
    try {
      // Cargar el archivo GPX desde los assets
      final gpxData =
          await DefaultAssetBundle.of(context).loadString('assets/ruta_test.gpx');

      // Procesar el archivo GPX
      final gpx = GpxReader().fromString(gpxData);

      // Extraer los puntos de la ruta (tracks o waypoints)
      final trackPoints = gpx.trks
          .expand((trk) => trk.trksegs) // Segmentar los tracks
          .expand((trkseg) => trkseg.trkpts) // Extraer los puntos
          .map((pt) => LatLng(pt.lat!, pt.lon!)) // Convertir a LatLng
          .toList();

      setState(() {
        _routePoints = trackPoints; // Almacenar los puntos en la ruta
      });
    } catch (e) {
      print('Error al cargar el archivo GPX: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : FlutterMap(
            options: MapOptions(
              initialCenter:
                  _routePoints.isNotEmpty ? _routePoints.first : LatLng(0, 0),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                tileProvider: MbTilesTileProvider.fromPath(path: _mbtilesPath),
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints, // Puntos de la ruta GPX
                    color: Colors.blue,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
            ],
          );
  }
}
