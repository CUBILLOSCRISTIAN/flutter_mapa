import 'dart:convert';
import 'package:flutter/services.dart';

Future<T> loadGeoJsonFromPath<T>(
    String path, T Function(Map<String, dynamic>) fromJson) async {
  final jsonString = await rootBundle.loadString(path);
  final jsonMap = jsonDecode(jsonString);
  return fromJson(jsonMap);
}

Future<Map<String, dynamic>> loadGeoJsonFromPathReturnJson<T>(
    String path, T Function(Map<String, dynamic>) fromJson) async {
  final jsonString = await rootBundle.loadString(path);

  final jsonMap = jsonDecode(jsonString);

  return jsonMap;
}
