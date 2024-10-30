import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/infraestructure/models/geojson_pois.dart';

abstract class ILocalPOIs {
  void fetchPOIs(GeoJsonPOIs poi);
  Future<List<PointOfInterest>> getPOIs();
}
