import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

class PointOfInterestModel extends PointOfInterest {
  PointOfInterestModel({
    required super.name,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.imageURL,
    required super.openingHours,
  });

  factory PointOfInterestModel.fromJson(Map<String, dynamic> json) {
    // final feature = json['feature'] ?? {};
    final properties = json['properties'] ?? {};
    final geometry = json['geometry'] ?? {};

    return PointOfInterestModel(
      name: properties['name'] ?? 'Sin nombre',
      description: properties['description'] ?? 'Sin descripción',
      latitude: geometry['coordinates'] != null ? geometry['coordinates'][1] ?? 0.0 : 0.0,
      longitude: geometry['coordinates'] != null ? geometry['coordinates'][0] ?? 0.0 : 0.0,
      imageURL: properties['imageURL'] ?? 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930',
      openingHours: properties['opening_hours'] ?? 'Sin horario de apertura',
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
