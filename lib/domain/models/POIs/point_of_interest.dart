class PointOfInterest {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final type = 'Point';

  PointOfInterest({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

}