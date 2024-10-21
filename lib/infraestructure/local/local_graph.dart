import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_mapa/domain/models/point_model.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_graph.dart';
import 'package:flutter_mapa/infraestructure/models/geojson.dart';
import 'package:flutter_mapa/infraestructure/models/graph.dart';

class LocalGraph implements ILocalRoute {

  Graph? _graph;


  @override
  List<PointModel> getShortestPath(PointModel start, PointModel end) {
    if (_graph == null) {
      throw Exception("Graph not loaded");
    }
    return _graph!.dijkstra(start, end) ?? [];
  }

  @override
  Future<GeoJson> loadGeoJson() async {
    final jsonString = await rootBundle.loadString('assets/map_geojson/roads.geojson');
    final jsonMap = jsonDecode(jsonString);
    return GeoJson.fromJson(jsonMap);
  }

  @override
  Graph loadGraph() {
    if (_graph == null) {
      throw Exception("Graph not loaded");
    }
    return _graph!;
  }

  @override
  Future<void> saveGraph(Graph graph) async{
    _graph = graph;
  }
}
