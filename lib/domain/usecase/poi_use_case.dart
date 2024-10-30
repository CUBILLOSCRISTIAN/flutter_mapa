import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/domain/repositories/i_pois_repository.dart';


class PoiUseCase {
  final IPOIsRepository _poiRepository;

  PoiUseCase(this._poiRepository);

  Future<List<PointOfInterest>> getPoiList() async {
    return _poiRepository.getPOIs();
  }

  void fetchPOIs() {
    _poiRepository.fetchPOIs();
  }
}