import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures/failure.dart';
import '../entitites/graph.dart';
import '../entitites/node.dart';

abstract class IGraphRepository {
  Future<Either<Failure, Unit>> createGraph();
  Future<Either<Failure, List<Node>>> getShortestPath(LatLng start, LatLng end);
  Future<Either<Failure, Graph>> getGraph();
}
