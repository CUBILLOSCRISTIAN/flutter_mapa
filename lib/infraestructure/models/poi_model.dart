import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

class PointOfInterestModel extends PointOfInterest {
  PointOfInterestModel({
    required super.name,
    required super.description,
    required super.latitude,
    required super.longitude,
  });

  factory PointOfInterestModel.fromJson(Map<String, dynamic> json) {
    // final feature = json['feature'] ?? {};
    print(json);
    final properties = json['properties'] ?? {};
    final geometry = json['geometry'] ?? {};

    return PointOfInterestModel(
      name: properties['name'] ?? 'Sin nombre',
      description: properties['description'] ?? 'Sin descripción',
      latitude: geometry['coordinates'] != null ? geometry['coordinates'][1] ?? 0.0 : 0.0,
      longitude: geometry['coordinates'] != null ? geometry['coordinates'][0] ?? 0.0 : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'features': {
        'properties': {
          'name': name,
          'description': description,
        },
        'geometry': {
          'coordinates': [longitude, latitude],
        },
      },
    };
  }
}
