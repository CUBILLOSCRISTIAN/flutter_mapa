import 'package:flutter_mapa/domain/models/point_model.dart';

abstract class IGraphRepository {
  Future<void> createGraph();
  List<PointModel> getShortestPath(PointModel start, PointModel end);
}
