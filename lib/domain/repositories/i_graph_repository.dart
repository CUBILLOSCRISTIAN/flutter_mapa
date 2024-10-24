import 'package:flutter_mapa/domain/models/graph.dart';
import 'package:flutter_mapa/domain/models/node.dart';
import 'package:latlong2/latlong.dart';

abstract class IGraphRepository {
  Future<void> createGraph();
  List<Node> getShortestPath(LatLng start, LatLng end);
  Graph getGraph();
}
