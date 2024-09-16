import 'package:flutter/material.dart';
import 'package:flutter_mapa/ui/pages/acceso_gps_page.dart';
import 'package:flutter_mapa/ui/pages/loading_page.dart';
import 'package:flutter_mapa/ui/pages/mapa_page.dart';
import 'package:get/get.dart';

import 'ui/controllers/ubicacion_controller.dart';


void main() {

  Get.put(UbicacionController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        'loading'   : (_) =>  LoadingPage(),
        'acceso_gps': (_) =>  AccesoGpsPage(),
        'mapa'      : (_) =>  MapaPage(),
      },
    );
  }
}
