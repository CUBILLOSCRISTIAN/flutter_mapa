import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/infraestructure/mappers/point_of_interest_mapper.dart';
import 'package:flutter_mapa/infraestructure/models/geojson_pois.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_pois.dart';

class LocalPOI implements ILocalPOIs{


  List<PointOfInterest>? _POIs;

  @override
  void fetchPOIs(GeoJsonPOIs geojson_pois) {
    // TODO: implement createPOIs

    //Recibo un GEOJSON lo mapeo a un objeto Pois
    _POIs = PointOfInterestMapper.fromGeoJson(geojson_pois);

    for (var poi in _POIs!) {
      print(poi.name);
    }
  }

  @override
  Future<List<PointOfInterest>> getPOIs() {
    if (_POIs == null) {
      throw Exception("POIs not loaded");
    }
    return Future.value(_POIs!);
  }



}