import 'package:flutter_mapa/domain/models/Graph/graph.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart';
import 'package:latlong2/latlong.dart';

abstract class IGraphRepository {
  Future<void> createGraph();
  List<Node> getShortestPath(LatLng start, LatLng end);
  Graph getGraph();
}
