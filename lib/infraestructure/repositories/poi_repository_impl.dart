import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/domain/repositories/i_pois_repository.dart';
import 'package:flutter_mapa/infraestructure/local/local_poi.dart';
import 'package:flutter_mapa/infraestructure/models/poi_model.dart';
import 'package:flutter_mapa/infraestructure/utils/load_geojson.dart';

class PoiRepositoryImpl implements IPOIsRepository {
  AbstractLocalPOIs _localPOIs;

  PoiRepositoryImpl(this._localPOIs);

  @override
  void fetchPOIs() async {
    final jsonString = await loadGeoJsonFromPathReturnJson(
        'assets/map_geojson/amenity_points.geojson',
        PointOfInterestModel.fromJson);

    _localPOIs.fetchPOIs(jsonString);
  }

  @override
  List<PointOfInterest> getPOIs() {
    return _localPOIs.getPOIs();
  }
}
