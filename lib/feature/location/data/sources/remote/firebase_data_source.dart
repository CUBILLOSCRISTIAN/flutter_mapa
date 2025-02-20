import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mapa/core/error/failures/failure.dart';
import 'package:flutter_mapa/feature/location/data/model/location_model.dart';
import 'package:flutter_mapa/feature/location/data/sources/remote/i_remote_data_source.dart';

class FirebaseDataSource implements IRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseDataSource(this.firestore);

  @override
  Future<Either<Failure, Unit>> saveLocationToServer(
      String routeId, List<LocationModel> locations) async {
    try {
      final batch = firestore.batch();
      final routeRef = firestore.collection('routes').doc(routeId);

      for (var location in locations) {
        final locationRef = routeRef.collection('locations').doc();
        batch.set(locationRef, location.toJson());
      }

      await batch.commit();
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
