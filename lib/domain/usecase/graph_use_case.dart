import 'package:flutter_mapa/domain/models/Graph/graph.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart';
import 'package:flutter_mapa/domain/repositories/i_graph_repository.dart';
import 'package:latlong2/latlong.dart';

class GraphUseCase {
  final IGraphRepository _graphRepository;

  GraphUseCase(this._graphRepository);

  List<Node> getShortestPath(LatLng start, LatLng end)  {
    return _graphRepository.getShortestPath(start, end);
  }

  Future<void> createGraph() async {
    await _graphRepository.createGraph();
  }

  Graph getGraph() {
    return _graphRepository.getGraph();
  }
}
