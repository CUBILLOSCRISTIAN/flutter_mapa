import 'package:flutter_mapa/domain/models/poi.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_poi.dart';

class LocalPOI implements ILocalPoi{


  List<POI>? _POIs;

  @override
  Future<void> createPOIs() {
    // TODO: implement createPOIs
    throw UnimplementedError();
  }

  @override
  Future<List<POI>> getPoiList() {
    if (_POIs == null) {
      throw Exception("POIs not loaded");
    }
    return Future.value(_POIs!);
  }



}