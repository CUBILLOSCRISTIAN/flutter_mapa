// ignore_for_file: constant_identifier_names

import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/feature/auth/presentation/page/auth_screen.dart';
import 'package:get/get.dart';

class RouterAuth {
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;

  static List<GetPage> getPages = [
    GetPage(
      name: LOGIN,
      page: () => AuthWrapper(),
    ),
    GetPage(
      name: REGISTER,
      page: () => AuthWrapper(),
    ),
  ];
}
