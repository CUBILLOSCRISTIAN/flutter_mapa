// ignore_for_file: constant_identifier_names

import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/feature/route/config/injection/setup_route_dependencies.dart';
import 'package:flutter_mapa/feature/route/presentation/home_page.dart';
import 'package:flutter_mapa/feature/route/presentation/wait_room_screen.dart';
import 'package:get/get.dart';

class RoutesRoute {
  static const String HOMEPAGE = Routes.HOME_PAGE;
  static const String WAITING_ROOM = Routes.WAITING_ROOM;

  static List<GetPage> getPages = [
    GetPage(
      name: HOMEPAGE,
      page: () {
        setupRouteDependencies();
        return HomePage();
      },
    ),
    GetPage(
      name: Routes.WAITING_ROOM,
      page: () {
        setupRouteDependencies();

        return WaitingRoomScreen(
          codeRoom: Get.parameters['codeRoom'] ?? '',
        );
      },
    ),
  ];
}
