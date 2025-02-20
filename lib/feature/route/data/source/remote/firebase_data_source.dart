import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/auth/data/models/user_model.dart';
import 'package:flutter_mapa/feature/route/data/models/route_model.dart';
import 'package:flutter_mapa/feature/route/data/source/remote/i_remote_data_source.dart';

class FirebaseDataSource implements IRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Future<Either<Failure, Unit>> joinRoute(
      String routeId, UserModel user) async {
    try {
      // Verificar si la ruta existe
      final snapshot = await FirebaseFirestore.instance
          .collection('rutas')
          .doc(routeId)
          .get();

      if (snapshot.exists) {
        // Obtener los datos del usuario actual

        await FirebaseFirestore.instance.collection('rutas').doc(routeId).set({
          'participantes': {user.id: user.toMap()}
        }, SetOptions(merge: true));
        return Right(unit);
      }
      return Left(JoinFailure());
    } catch (e) {
      return Left(JoinFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createRoute(RouteModel model) async {
    try {
      await _firestore.collection('rutas').doc(model.codigo).set(model.toMap());

      return Right(unit);
    } catch (e) {
      return Left(CreateFailure());
    }
  }
}
