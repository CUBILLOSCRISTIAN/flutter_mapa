import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_mapa/ui/pages/map_detail_view.dart';
// import 'package:flutter_map_mbtiles/flutter_map_mbtiles_image_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

class DetailRoute extends StatelessWidget {
  final int tag;
  const DetailRoute({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: size.height * 0.5,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: tag,
                    child: Image.network(
                      'https://plus.unsplash.com/premium_photo-1700143162587-5c09d6e3eece?q=80&w=2875&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0.0, 0.3],
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Especies nativas y exoticas',
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            'Uninorte',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          Text(
                            '1.8 (12k Reseñas)',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: size.height * 0.50),
                Text(
                  'Descripcion',
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AbsorbPointer(
                      child: MbtilesMap(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapDetailView()),
                          );
                        },
                        child: Text('Ver la ruta'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MbtilesMap extends StatefulWidget {
  const MbtilesMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MbtilesMapState createState() => _MbtilesMapState();
}

class _MbtilesMapState extends State<MbtilesMap> {
  late String _mbtilesPath; // Ruta al archivo MBTiles
  bool _isLoading = true; // Bandera para controlar si los datos están cargando

  @override
  void initState() {
    super.initState();
    _loadMbtiles(); // Cargar el archivo MBTiles
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

      // Actualizar el estado cuando el archivo se haya copiado
      setState(() {
        _mbtilesPath = tempPath;
        _isLoading = false; // Indicar que ya está listo
      });
    } catch (e) {
      // Manejo de errores al cargar el archivo
      print('Error al cargar el archivo MBTiles: $e');
      setState(() {
        _isLoading = false; // Detener el indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          ) // Mostrar un indicador de carga mientras el archivo se copia
        : FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(11.018974, -74.849614), // Coordenadas iniciales
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                // Usar el archivo MBTiles cargado
                tileProvider: MbTilesTileProvider.fromPath(path: _mbtilesPath),
              ),
              MarkerLayer(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(11.018974, -74.849614),
                  child: const Icon(
                    Icons.location_on,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ])
            ],
          );
  
  }
}
