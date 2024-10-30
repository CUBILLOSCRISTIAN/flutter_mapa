import 'package:flutter_mapa/domain/models/Graph/edge.dart';
import 'package:latlong2/latlong.dart';

class Node {
  final LatLng coordinates; // LatLng from latlong2 library
  final List<Edge> neighbors;

  Node(this.coordinates, this.neighbors);
}
