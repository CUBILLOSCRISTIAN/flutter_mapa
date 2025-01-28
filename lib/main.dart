import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/ui/pages/acceso_gps_page.dart';
import 'package:flutter_mapa/ui/pages/detail_route.dart';
import 'package:flutter_mapa/ui/pages/home_page.dart';
import 'package:flutter_mapa/ui/pages/loading_page.dart';
import 'package:get/get.dart';

import 'ui/controllers/ubicacion_controller.dart';

void main() {
  Get.put(LocationController());

  // Get.put<ILocalRoute>(LocalGraph());
  // Get.put<IGraphRepository>(GraphRepositoryImpl(Get.find()));
  // // Get.put(GraphUseCase(Get.find()));
  // // Get.put(GraphController(Get.find()));

  // Get.put<AbstractLocalPOIs>(LocalPOI());
  // Get.put<IPOIsRepository>(PoiRepositoryImpl(Get.find()));
  // Get.put(PoiUseCase(Get.find()));
  // Get.put(PoisController(Get.find()));

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
        'mapa': (_) => HomePage(),
        'detail': (_) => const DetailRoute(tag: 1,),
      },
      builder: (context, child) {
        return Theme(
          data: ThemeData(),
          child: Material(child: child),
        );
      },
    );
  }
}
