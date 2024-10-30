import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/domain/repositories/i_pois_repository.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_pois.dart';
import 'package:flutter_mapa/infraestructure/models/geojson_pois.dart';
import 'package:flutter_mapa/infraestructure/utils/load_geojson.dart';

class PoiRepositoryImpl extends IPOIsRepository {
  ILocalPOIs _localPOIs;

  PoiRepositoryImpl(this._localPOIs);

  @override
  void fetchPOIs() async {
    final geoJsonData = await loadGeoJsonFromPath<GeoJsonPOIs>(
        'assets/map_geojson/amenity_points.geojson', GeoJsonPOIs.fromJson);

    _localPOIs.fetchPOIs(geoJsonData);
  }

  @override
  Future<List<PointOfInterest>> getPOIs() {
    return _localPOIs.getPOIs();
  }
}
