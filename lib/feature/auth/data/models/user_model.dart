import 'dart:convert';

import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.email,
      required super.role,
      required super.locations});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role.toString().split('.').last,
      // 'locations': locations.map((x) => x.toMap()).toList(),
    };
  }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'],
  //     email: map['email'],
  //     role: map['role'],
  //     locations: List<LocationEntity>.from(
  //         map['locations']?.map((x) => LocationEntity.fromMap(x))),
  //   );
  // }

  //ToEntity

  factory UserModel.toEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      role: entity.role,
      locations: entity.locations,
    );
  }

  String toJson() => json.encode(toMap());
}
