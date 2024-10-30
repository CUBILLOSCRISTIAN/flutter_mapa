
import 'package:get/get.dart';
import 'package:flutter_mapa/domain/usecase/poi_use_case.dart';

class PoiController extends GetxController {

  final PoiUseCase _poiUseCase;

  List<PointOfInterest> get poiList => _poiUseCase.getPoiList();

  PoiController(this._poiUseCase);


  Future<void> fetchPOIs() async {
    _poiUseCase.fetchPOIs();
  }

  

}