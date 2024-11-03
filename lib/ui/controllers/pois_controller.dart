import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/domain/usecase/poi_use_case.dart';
import 'package:get/get.dart';

class PoisController extends GetxController {
  final PoiUseCase _poiUseCase;

  PoisController(this._poiUseCase);

  @override
  void onInit() {
    super.onInit();
    fetchPOIs();
  }

  List<PointOfInterest> get poiList => _poiUseCase.getPoiList();

  Future<void>fetchPOIs() async {
    _poiUseCase.fetchPOIs();
  }

  Future<List<PointOfInterest>> searchPOIs(String query) async {
    return poiList
        .where((poi) => poi.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
