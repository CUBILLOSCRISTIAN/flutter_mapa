import 'package:flutter_mapa/domain/models/poi.dart';

abstract class IPoiRepository {
  Future<void> createPOIs();
  Future<List<POI>> getPoiList();
}