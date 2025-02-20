import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LocationEntity {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final DateTime timestamp;

  LocationEntity({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });
}
