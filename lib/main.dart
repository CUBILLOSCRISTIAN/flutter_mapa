import 'package:flutter/material.dart';
import 'package:flutter_mapa/ui/controllers/graph_controller.dart';
import 'package:flutter_mapa/ui/controllers/pois_controller.dart';
import 'package:flutter_mapa/domain/repositories/i_graph_repository.dart';
import 'package:flutter_mapa/domain/repositories/i_pois_repository.dart';
import 'package:flutter_mapa/domain/usecase/graph_use_case.dart';
import 'package:flutter_mapa/domain/usecase/poi_use_case.dart';
import 'package:flutter_mapa/infraestructure/local/local_graph.dart';
import 'package:flutter_mapa/infraestructure/local/local_poi.dart';
import 'package:flutter_mapa/infraestructure/repositories/graph_repository_impl.dart';
import 'package:flutter_mapa/infraestructure/repositories/poi_repository_impl.dart';
import 'package:flutter_mapa/ui/pages/acceso_gps_page.dart';
import 'package:flutter_mapa/ui/pages/loading_page.dart';
import 'package:flutter_mapa/ui/pages/mapa_page.dart';
import 'package:get/get.dart';

import 'ui/controllers/ubicacion_controller.dart';

void main() {
  Get.put(LocationController());

  Get.put<ILocalRoute>(LocalGraph());
  Get.put<IGraphRepository>(GraphRepositoryImpl(Get.find()));
  Get.put(GraphUseCase(Get.find()));
  Get.put(GraphController(Get.find()));

  Get.put<AbstractLocalPOIs>(LocalPOI());
  Get.put<IPOIsRepository>(PoiRepositoryImpl(Get.find()));
  Get.put(PoiUseCase(Get.find()));
  Get.put(PoisController(Get.find()));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      routes: {
        'loading': (_) => const LoadingPage(),
        'acceso_gps': (_) => const AccesoGpsPage(),
        'mapa': (_) => const MapaPage(),
      },
    );
  }
}
