import 'package:flutter_mapa/infraestructure/models/geojson_pois.dart';

abstract class IPOIsRepository {
  Future<void> createPOIs();
  Future<List<GeoJsonPOIs>> getPOIs();
}