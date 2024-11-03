
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

Future<T> loadGeoJsonFromPath<T>(String path, T Function(Map<String, dynamic>) fromJson) async {
  final jsonString = await rootBundle.loadString(path);
  final jsonMap = jsonDecode(jsonString);
  return fromJson(jsonMap);
}

Future<Map<String, dynamic>> loadGeoJsonFromPathReturnJson<T>(String path, T Function(Map<String, dynamic>) fromJson) async {
  final jsonString = await rootBundle.loadString(path);
  print('JSON String loaded'); // Verifica si esta línea se ejecuta
  final jsonMap = jsonDecode(jsonString);
  print('JSON Decoded'); // Verifica si esta línea se ejecuta

  return jsonMap;
}