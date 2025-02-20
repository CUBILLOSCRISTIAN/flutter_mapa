import 'package:flutter_mapa/feature/location/domain/entities/location_entity.dart';

class UserEntity {
  final String id;
  final String email;
  final UserRole role;
  final List<LocationEntity> locations;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.locations,
  });
}

enum UserRole {
  admin,
  guide,
  participant,
}
