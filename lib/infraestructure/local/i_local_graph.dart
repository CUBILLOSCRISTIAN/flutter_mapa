import 'package:flutter_mapa/domain/models/point_model.dart';
import 'package:flutter_mapa/infraestructure/models/geojson.dart';
import 'package:flutter_mapa/infraestructure/models/graph.dart';

abstract class ILocalRoute {
  Future<GeoJson> loadGeoJson();
  Future<void> saveGraph(Graph graph);
  Graph loadGraph();
  List<PointModel> getShortestPath(PointModel start, PointModel end);
}
