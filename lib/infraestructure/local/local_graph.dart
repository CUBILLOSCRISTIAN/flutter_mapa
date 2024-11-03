import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mapa/domain/models/Graph/edge.dart';
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


class LocalGraph implements ILocalRoute {
  Graph? _graph;

  @override
  List<Node> getShortestPath(LatLng start, LatLng end) {
    if (_graph == null) {
      throw Exception("Graph not loaded");
    }

    return aStar(start, end, _graph!.nodes);
  }

  @override
  Graph loadGraph() {
    if (_graph == null) {
      throw Exception("Graph not loaded");
    }
    return _graph!;
  }

  @override
  Future<void> saveGraph(Graph graph) async {
    _graph = graph;
  }

  @override
  Future<Graph> createGraph(GeoJsonRoads geoJsonData) async {
    final Map<String, Node> nodes = {};

    if (geoJsonData.features != null) {
      for (var feature in geoJsonData.features!) {
      if (feature.geometry!.type == GeometryType.LINE_STRING) {
        List<List<double>> coordinates = feature.geometry!.coordinates!;

        for (int i = 0; i < coordinates.length - 1; i++) {
          var startCoord = LatLng(coordinates[i][1], coordinates[i][0]);
          var endCoord = LatLng(coordinates[i + 1][1], coordinates[i + 1][0]);

          var startKey = startCoord.toString();
          var endKey = endCoord.toString();

          if (!nodes.containsKey(startKey)) {
            nodes[startKey] = Node(startCoord, []);
          }
          if (!nodes.containsKey(endKey)) {
            nodes[endKey] = Node(endCoord, []);
          }

          var edge = Edge(nodes[endKey]!, 1.0); // Peso arbitrario
          nodes[startKey]?.neighbors.add(edge);
        }
      }
      }
    }
    return Graph(nodes);
    
  }

  List<Node> aStar(LatLng startCoord, LatLng goalCoord, Map<String, Node> nodes) {
      debugPrint("A*");
      debugPrint("Start: $startCoord");
      debugPrint("Goal: $goalCoord");
      debugPrint('Node Start: ${nodes[startCoord.toString()]}');

    final start = nodes[startCoord.toString()]!;
    final goal = nodes[goalCoord.toString()]!;
    final openSet = <Node>{start};
    final cameFrom = <Node, Node>{};

    final gScore = <Node, double>{};

    
    for (var node in nodes.values) {
      gScore[node] = double.infinity;
    }
    gScore[start] = 0;

    final fScore = <Node, double>{};
    for (var node in nodes.values) {
      fScore[node] = double.infinity;
    }
    fScore[start] = _heuristicCostEstimate(start, goal);

    while (openSet.isNotEmpty) {
      final current = openSet.reduce((a, b) => fScore[a]! < fScore[b]! ? a : b);

      if (current == goal) {
        return _reconstructPath(cameFrom, current);
      }

      openSet.remove(current);

      for (final neighbor in current.neighbors) {
        final tentativeGScore =
            gScore[current]! + _distanceBetween(current, neighbor.destination);

        if (tentativeGScore < gScore[neighbor.destination]!) {
          cameFrom[neighbor.destination] = current;
          gScore[neighbor.destination] = tentativeGScore;
          fScore[neighbor.destination] = gScore[neighbor.destination]! +
              _heuristicCostEstimate(neighbor.destination, goal);

          if (!openSet.contains(neighbor.destination)) {
            openSet.add(neighbor.destination);
          }
        }
      }
    }

    return [];
  }

  double _heuristicCostEstimate(Node start, Node goal) {
    // Implementa tu función heurística aquí
    // Suponiendo que las coordenadas están en formato "lat,lon"
    final startCoords = start.coordinates;
    final goalCoords = goal.coordinates;

    final dx = startCoords.latitude - goalCoords.latitude;
    final dy = startCoords.longitude - goalCoords.longitude;

    return sqrt(dx * dx + dy * dy);
  }

  double _distanceBetween(Node a, Node b) {
    // Implementa tu función de distancia aquí
    // Suponiendo que las coordenadas están en formato "lat,lon"
    final startCoords = a.coordinates;
    final endCoords = b.coordinates;

    final dx = startCoords.latitude - endCoords.latitude;
    final dy = startCoords.longitude - endCoords.longitude;

    return sqrt(dx * dx + dy * dy);

  }

  List<Node> _reconstructPath(Map<Node, Node> cameFrom, Node current) {
    final totalPath = <Node>[current];
    while (cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      totalPath.add(current);
    }
    return totalPath.reversed.toList();
  }
}
