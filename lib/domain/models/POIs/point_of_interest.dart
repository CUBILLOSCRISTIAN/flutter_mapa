class PointOfInterest {
  // final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String imageURL;
  final String openingHours;
  final type = 'Point';

  PointOfInterest({
    // required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
    required this.openingHours,
  });

}