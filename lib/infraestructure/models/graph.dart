import 'package:flutter_mapa/domain/models/point_model.dart';

class Graph {
  final Map<PointModel, Map<PointModel, double>> _adjacencyList = {};

  void addEdge(PointModel start, PointModel end, double weight) {
    _adjacencyList.putIfAbsent(start, () => {});
    _adjacencyList[start]![end] = weight;

    _adjacencyList.putIfAbsent(end, () => {});
    _adjacencyList[end]![start] = weight;
  }

  List<PointModel>? dijkstra(PointModel start, PointModel end) {
    final distances = <PointModel, double>{};
    final previous = <PointModel, PointModel?>{};
    final nodes = <PointModel>{};

    for (var node in _adjacencyList.keys) {
      distances[node] = double.infinity;
      previous[node] = null;
      nodes.add(node);
    }
    distances[start] = 0;

    while (nodes.isNotEmpty) {
      final currentNode =
          nodes.reduce((a, b) => distances[a]! < distances[b]! ? a : b);
      nodes.remove(currentNode);

      if (currentNode == end) {
        final path = <PointModel>[];
        var step = end;
        while (previous[step] != null) {
          path.insert(0, step);
          step = previous[step]!;
        }
        path.insert(0, start);
        return path;
      }

      if (distances[currentNode] == double.infinity) {
        break;
      }

      for (var neighbor in _adjacencyList[currentNode]!.keys) {
        final alt =
            distances[currentNode]! + _adjacencyList[currentNode]![neighbor]!;
        if (alt < distances[neighbor]!) {
          distances[neighbor] = alt;
          previous[neighbor] = currentNode;
        }
      }
    }

    return null; // No hay ruta
  }
}
