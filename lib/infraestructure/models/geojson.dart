import 'package:flutter_mapa/infraestructure/models/feacture.dart';

class GeoJson {
  final List<Feature> features;

  GeoJson(this.features);

  factory GeoJson.fromJson(Map<String, dynamic> json) {
    var featuresJson = json['features'] as List;
    List<Feature> featuresList =
        featuresJson.map((i) => Feature.fromJson(i)).toList();
    return GeoJson(featuresList);
  }
}
