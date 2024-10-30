import 'package:flutter_mapa/domain/models/poi.dart';
import 'package:flutter_mapa/domain/repositories/i_poi_repository.dart';

class PoiUseCasse {
  final IPoiRepository _poiRepository;

  PoiUseCasse(this._poiRepository);

  Future<List<POI>> getPoiList() async {
    return  _poiRepository.getPoiList();
  }
}