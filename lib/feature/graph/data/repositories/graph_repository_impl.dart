import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../infraestructure/models/geojson_roads.dart';
import '../../../../infraestructure/utils/load_geojson.dart';
import '../../domain/entitites/graph.dart';
import '../../domain/entitites/node.dart';
import '../../domain/repositories/i_graph_repository.dart';
import '../sources/local/local_graph.dart';

class GraphRepositoryImpl implements IGraphRepository {
  final ILocalRoute _localGraph;

  GraphRepositoryImpl(this._localGraph);

  @override
  Future<Either<Failure, Unit>> createGraph() async {
    // final geoJsonData = await _localGraph.loadGeoJson();

    final geoJsonData = await loadGeoJsonFromPath<GeoJsonRoads>(
        'assets/map_geojson/roads.geojson', GeoJsonRoads.fromJson);

    try {
      final graph = await _localGraph.createGraph(geoJsonData);
      await _localGraph.saveGraph(graph);
      return Right(unit);
    } catch (e) {
      return Left(
        PathFailure('Error creando grafo.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Node>>> getShortestPath(
      LatLng start, LatLng end) async {
    try {
      final path = _localGraph.getShortestPath(start, end);
      return Right(path);
    } catch (e) {
      return Left(
        PathFailure('Error obteniendo ruta.'),
      );
    }
  }

  @override
  Future<Either<Failure, Graph>> getGraph() async {
    try {
      final graph = _localGraph.loadGraph();
      return Right(graph);
    } catch (e) {
      return Left(
        PathFailure('Error obteniendo el grafo.'),
      );
    }
  }
}
