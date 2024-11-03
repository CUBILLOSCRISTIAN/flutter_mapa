import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

import 'package:flutter_mapa/infraestructure/models/poi_model.dart';

//Clase abstracta

abstract class AbstractLocalPOIs {
  void fetchPOIs(Map<String, dynamic> poi);
  List<PointOfInterest> getPOIs();
}

class LocalPOI implements AbstractLocalPOIs {
  List<PointOfInterest>? _POIs;

  @override
  void fetchPOIs(Map<String, dynamic> geojsonPois) {

    _POIs = geojsonPois['features']
        .map<PointOfInterest>((poi) => PointOfInterestModel.fromJson(poi))
        .toList();
  }

  @override
  List<PointOfInterest> getPOIs() {
    //* Verifico si _POIs es nulo, si es nulo retorno una lista vacía
    if (_POIs == null) {
      [];
    }
    return _POIs!;
  }
}
