
import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';
import 'package:flutter_mapa/infraestructure/models/geojson_pois.dart';

class PointOfInterestMapper {
  static PointOfInterest fromGeoJsonFeature(Feature feature) {
    return PointOfInterest(
      id: feature.properties?.osmId?.toString() ?? '',
      name: feature.properties?.name ?? 'Unknown',
      description: feature.properties?.amenity ?? 'No description',
      latitude: feature.geometry?.coordinates?[1] ?? 0.0,
      longitude: feature.geometry?.coordinates?[0] ?? 0.0,
    );
  }

  static List<PointOfInterest> fromGeoJson(GeoJsonPOIs geoJsonPOIs) {
    return geoJsonPOIs.features?.map((feature) => fromGeoJsonFeature(feature)).toList() ?? [];
  }
}