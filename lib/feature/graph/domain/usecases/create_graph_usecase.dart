import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/core/interfaces/domain/i_usecase.dart';
import 'package:flutter_mapa/feature/graph/domain/repositories/i_graph_repository.dart';

/// Caso de uso responsable de crear un grafo
class CreateGraphUsecase implements IUsecase<Unit, Null> {
  final IGraphRepository _repository;

  CreateGraphUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call({required Null params}) async {
    return await _repository.createGraph();
  }
}
