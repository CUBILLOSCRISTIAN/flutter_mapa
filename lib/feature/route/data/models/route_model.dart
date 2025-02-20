import 'package:flutter_mapa/feature/route/domain/entity/route.dart';

class RouteModel extends RouteEntity {
  RouteModel({
    required super.id,
    required super.codigo,
    super.estado = "pendiente",
    super.visitantes = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'estado': estado,
      'visitantes': visitantes,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'],
      codigo: map['codigo'],
      estado: map['estado'],
      visitantes: List<String>.from(map['visitantes']),
    );
  }

  factory RouteModel.toEntity(RouteEntity entity) {
    return RouteModel(
      id: entity.id,
      codigo: entity.codigo,
      estado: entity.estado,
      visitantes: entity.visitantes,
    );
  }
}
