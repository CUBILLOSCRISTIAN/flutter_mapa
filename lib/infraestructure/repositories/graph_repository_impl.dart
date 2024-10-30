
import 'package:flutter_mapa/infraestructure/models/geojson_roads.dart';
import 'package:flutter_mapa/domain/models/Graph/graph.dart';
import 'package:flutter_mapa/domain/models/Graph/node.dart';

import 'package:flutter_mapa/domain/repositories/i_graph_repository.dart';
import 'package:flutter_mapa/infraestructure/local/i_local_graph.dart';
import 'package:flutter_mapa/infraestructure/utils/load_geojson.dart';
import 'package:latlong2/latlong.dart';

class GraphRepositoryImpl implements IGraphRepository {
  final ILocalRoute _localGraph;

  GraphRepositoryImpl(this._localGraph);

  @override
  Future<void> createGraph() async {
    // final geoJsonData = await _localGraph.loadGeoJson();

    final geoJsonData = await loadGeoJsonFromPath<GeoJsonRoads>('assets/map_geojson/roads.geojson', GeoJsonRoads.fromJson);

    Graph graph = await _localGraph.createGraph(geoJsonData);
    _localGraph.saveGraph(graph);
  }

  @override
  List<Node> getShortestPath(LatLng start, LatLng end) {
    return _localGraph.getShortestPath(start, end);
  }

  @override
  Graph getGraph() {
    return _localGraph.loadGraph();
  }

}
