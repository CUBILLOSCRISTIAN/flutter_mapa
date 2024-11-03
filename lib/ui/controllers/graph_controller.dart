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

  List<domain.Node> findShortestPath(LatLng start, LatLng end) {
    print('start: $start');
    print('end: $end');
    return _graphUseCase.getShortestPath(start, end);
  }
}
