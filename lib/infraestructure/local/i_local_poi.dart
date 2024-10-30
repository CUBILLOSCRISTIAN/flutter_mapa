import 'package:flutter_mapa/domain/models/poi.dart';

abstract class ILocalPoi {
  Future<void> createPOIs();
  Future<List<POI>> getPoiList();
}
