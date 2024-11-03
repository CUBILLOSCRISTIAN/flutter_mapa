import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

abstract class IPOIsRepository {
  void fetchPOIs();
  List<PointOfInterest> getPOIs();
}