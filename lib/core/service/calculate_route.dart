// import 'dart:convert' show json;

// import 'package:flutter/services.dart' show rootBundle;

// import 'package:latlong2/latlong.dart' show LatLng;

// Future<void> calculateRoute(LatLng from, LatLng to) async {
//   final geojsonString =
//       await rootBundle.loadString('assets/rutas/GeoJSON_rutas.geojson');
//   final geojsonData = json.decode(geojsonString);
//   final featureCollection = turf.FeatureCollection.fromJson(geojsonData);

//   turf.LineString? shortestRoute;
//   double shortestDistance = double.infinity;

//   for (var feature in featureCollection.features) {
//     if (feature.geometry is turf.LineString) {
//       var line = feature.geometry as turf.LineString;
//       // Usamos la función correcta de turf para calcular la distancia de la línea
//       var distance = turf.length(
//           turf.Feature<turf.LineString>(geometry: line), turf.Unit.meters);

//       if (distance < shortestDistance) {
//         shortestDistance = distance.toDouble();
//         shortestRoute = line;
//       }
//     }
//   }

//   if (shortestRoute!.coordinates.isNotEmpty) {
//     print("Ruta más corta encontrada: ${shortestRoute.coordinates}");
//   } else {
//     print("No se encontró una ruta válida");
//   }
// }
