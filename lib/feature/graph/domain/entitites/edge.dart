import 'package:flutter_mapa/feature/graph/domain/entitites/node.dart';

class Edge {
  final Node destination;
  final double weight;

  Edge(this.destination, this.weight);
}