import 'package:flutter_mapa/domain/models/geojson.dart';
import 'package:flutter_mapa/domain/models/graph.dart';
import 'package:flutter_mapa/domain/models/node.dart';
import 'package:latlong2/latlong.dart';

abstract class ILocalRoute {
  Future<void> saveGraph(Graph graph);
  Graph loadGraph();
  List<Node> getShortestPath(LatLng start, LatLng end);
  Future<Graph> createGraph(GeoJson geoJsonData);
}
