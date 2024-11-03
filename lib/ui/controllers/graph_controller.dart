import 'package:flutter_mapa/domain/models/Graph/graph.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart' as domain;
import 'package:flutter_mapa/domain/usecase/graph_use_case.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class GraphController extends GetxController {
  final GraphUseCase _graphUseCase;

  Graph get graph => _graphUseCase.getGraph();

  GraphController(this._graphUseCase);

  @override
  void onInit() {
    super.onInit();
    createGraph();
  }

  Future<void> createGraph() async {
    await _graphUseCase.createGraph();
  }

  List<domain.Node> findShortestPath(LatLng? start, LatLng? end) {
    const start = LatLng(
                        11.0194067,-74.849615);
    const end = LatLng(11.0196014, -74.8488317);
    return _graphUseCase.getShortestPath(start, end);
  }
}
