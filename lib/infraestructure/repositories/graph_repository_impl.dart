import 'package:flutter_mapa/domain/models/point_model.dart';
import 'package:flutter_mapa/domain/repositories/i_graph_repository.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_graph.dart';
import 'package:flutter_mapa/infraestructure/models/graph.dart';

class GraphRepositoryImpl implements IGraphRepository {
  final ILocalRoute _localGraph;

  GraphRepositoryImpl(this._localGraph);

  @override
  Future<void> createGraph() async {
    final geoJson = await _localGraph.loadGeoJson();
    final graph = Graph();

    for (var feature in geoJson.features) {
      for (var i = 0; i < feature.coordinates.length - 1; i++) {
        final start = feature.coordinates[i];
        final end = feature.coordinates[i + 1];
        graph.addEdge(start, end, 1); // Puedes ajustar el peso según tus necesidades
      }
    }

    return _localGraph.saveGraph(graph);
  }

  @override
  List<PointModel> getShortestPath(PointModel start, PointModel end) {
    return _localGraph.getShortestPath( start, end);
  }
}
