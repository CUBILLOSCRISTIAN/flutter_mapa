import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/injection/setup_dependencies.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/feature/auth/presentation/page/auth_screen.dart';
import 'package:flutter_mapa/feature/location/data/model/location_model.dart';
import 'package:flutter_mapa/ui/pages/loading_page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'ui/controllers/ubicacion_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  //FIREBASE
  await Firebase.initializeApp();

  // Hive.registerAdapter(LocationModelAdapter()); // Registra el adaptador
  await Hive.openBox<LocationModel>(
      'locationsBox'); // Abre una caja para las ubicaciones

  setupDependencies(); // Inicializa las dependencias
  //Controlador para obtener la posicion
  Get.put(LocationController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //Quitamos el banner de debug
      debugShowCheckedModeBanner: false,

      // Ruta desconocida
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => AuthScreen()),

      // Ruta inicial
      home: LoadingPage(),

      getPages: AppRouter.getPages,

      //Tema de la aplicacion
      builder: (context, child) {
        return Theme(
          data: ThemeData(),
          child: Material(child: child),
        );
      },
    );
  }
}
