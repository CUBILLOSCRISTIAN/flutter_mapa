import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failure.dart';
import '../../../../core/interfaces/domain/i_usecase.dart';
import '../entitites/graph.dart';
import '../repositories/i_graph_repository.dart';

/// Caso de uso responsable de obtener el grafo
class GetGraphUsecase implements IUsecase<Graph, Null> {
  final IGraphRepository _repository;

  GetGraphUsecase(this._repository);

  @override
  Future<Either<Failure, Graph>> call({required Null params}) async {
    return await _repository.getGraph();
  }
}
