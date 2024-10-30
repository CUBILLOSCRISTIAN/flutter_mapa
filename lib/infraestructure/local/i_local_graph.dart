import 'package:flutter_mapa/infraestructure/models/geojson_roads.dart';
import 'package:flutter_mapa/domain/models/Graph/graph.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart';
import 'package:latlong2/latlong.dart';

abstract class ILocalRoute {
  Future<void> saveGraph(Graph graph);
  Graph loadGraph();
  List<Node> getShortestPath(LatLng start, LatLng end);
  Future<Graph> createGraph(GeoJsonRoads geoJsonData);
}
