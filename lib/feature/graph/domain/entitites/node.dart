import 'package:flutter_mapa/feature/graph/domain/entitites/edge.dart';
import 'package:latlong2/latlong.dart';

class Node {
  final LatLng coordinates;
  final List<Edge> neighbors;

  Node(this.coordinates, this.neighbors);
}
