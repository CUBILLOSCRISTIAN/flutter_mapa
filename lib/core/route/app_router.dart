// ignore_for_file: constant_identifier_names

import 'package:flutter_mapa/feature/auth/config/routes/router_auth.dart';
import 'package:flutter_mapa/feature/route/config/routes/routes_route.dart';
import 'package:flutter_mapa/ui/pages/acceso_gps_page.dart';
import 'package:flutter_mapa/ui/pages/loading_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppRouter {
  static const LOADING = Routes.LOADING;
  static const ACCESO_GPS = Routes.ACCESO_GPS;

  static List<GetPage> getPages = [
    GetPage(
      name: LOADING,
      page: () => LoadingPage(),
    ),
    GetPage(
      name: ACCESO_GPS,
      page: () => AccesoGpsPage(),
    ),
    ...RouterAuth.getPages,
    ...RoutesRoute.getPages,
  ];
}
