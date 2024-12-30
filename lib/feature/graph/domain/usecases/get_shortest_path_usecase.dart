import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../core/interfaces/domain/i_usecase.dart';
import '../entitites/node.dart';
import '../repositories/i_graph_repository.dart';

/// Caso de uso responsable de obtener el camino más corto
/// entre dos puntos
///
/// Recibe una tupla de dos LatLng, el primer valor es el punto de inicio
/// y el segundo valor es el punto de fin
class GetShortestPathUsecase
    implements IUsecase<List<Node>, Tuple2<LatLng, LatLng>> {
  final IGraphRepository _repository;

  GetShortestPathUsecase(this._repository);

  @override
  Future<Either<Failure, List<Node>>> call(
      {required Tuple2<LatLng, LatLng> params}) async {
    return await _repository.getShortestPath(params.value1, params.value2);
  }
}
