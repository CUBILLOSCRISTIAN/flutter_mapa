import 'package:dartz/dartz.dart';

import '../../error/failures/failure.dart';

///Interfase de los casos de uso
///
///[Type] es el tipo de dato que se espera obtener
///
///[Params] son los parametros que recibe el caso de uso
///
///[call] es el metodo que se encarga de ejecutar el caso de uso
abstract interface class IUsecase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
