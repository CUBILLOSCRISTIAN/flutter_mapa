import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mapa/pages/acceso_gps_page.dart';
import 'package:flutter_mapa/pages/loading_page.dart';
import 'package:flutter_mapa/pages/mapa_page.dart';

import 'bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          'loading'   : (_) =>  LoadingPage(),
          'acceso_gps': (_) =>  AccesoGpsPage(),
          'mapa'      : (_) =>  MapaPage(),
        },
      ),
    );
  }
}
