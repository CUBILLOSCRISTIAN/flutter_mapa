import 'package:flutter_mapa/domain/models/point_model.dart';
import 'package:flutter_mapa/domain/repositories/i_graph_repository.dart';

class RouteUseCase {
  final IGraphRepository _graphRepository;

  RouteUseCase(this._graphRepository);

  Future<List<PointModel>> getShortestPath(
      PointModel start, PointModel end) async {
    return await _graphRepository.getShortestPath(start, end);
  }

  Future<void> createGraph() async {
    return await _graphRepository.createGraph();
  }
}
