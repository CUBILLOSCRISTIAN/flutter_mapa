import 'package:flutter_mapa/domain/models/point_model.dart';

class Feature {
  final List<PointModel> coordinates;

  Feature(this.coordinates);

  factory Feature.fromJson(Map<String, dynamic> json) {
    var coordinatesJson = json['geometry']['coordinates'] as List;
    List<PointModel> coordinatesList = coordinatesJson.map((i) => PointModel(i[0], i[1])).toList();
    return Feature(coordinatesList);
  }
}