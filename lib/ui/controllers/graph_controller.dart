import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/graph/domain/entitites/graph.dart';
import 'package:flutter_mapa/feature/graph/domain/entitites/node.dart'
    as domain;

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../feature/graph/domain/usecases/create_graph_usecase.dart';
import '../../feature/graph/domain/usecases/get_graph_usecase.dart';
import '../../feature/graph/domain/usecases/get_shortest_path_usecase.dart';

class GraphController extends GetxController {
  final CreateGraphUsecase _createGraphUsecase;
  final GetGraphUsecase _getGraphUsecase;
  final GetShortestPathUsecase _getShortestPathUsecase;

  Future<Either<Failure, Graph>> get graph => _getGraphUsecase(params: null);

  GraphController(
    this._createGraphUsecase,
    this._getGraphUsecase,
    this._getShortestPathUsecase,
  );

  @override
  void onInit() {
    super.onInit();
    createGraph();
  }

  Future<void> createGraph() async {
    await _createGraphUsecase(params: null);
  }

  Future<Either<Failure, List<domain.Node>>> findShortestPath(
      LatLng start, LatLng end) async {

        
    return await _getShortestPathUsecase(params: Tuple2(start, end));
  }
}
