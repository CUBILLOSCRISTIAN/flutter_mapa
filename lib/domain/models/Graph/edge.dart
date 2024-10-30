import 'package:flutter_mapa/domain/models/Graph/node.dart';

class Edge {
  final Node destination;
  final double weight;

  Edge(this.destination, this.weight);
}