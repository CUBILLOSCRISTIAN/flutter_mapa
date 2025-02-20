import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:get/get.dart';

class NavigationServices {
  // GlobalKey para manejar el contexto en cualquier parte de la app.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Navega a una ruta específica con parámetros opcionales.
  static void navigateWithPush(String routeName,
      {Map<String, String>? queryParams}) {
    // // Construir la query string si hay parámetros
    // if (queryParams != null) {
    //   final query = queryParams.entries
    //       .map((e) =>
    //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    //       .join('&');
    //   // Usamos push() para actualizar tanto la URL como la pila de navegación
    //   Get.toNamed('$routeName?$query');
    // } else {
    // Usamos push() para actualizar la URL y la pila de navegación
    Get.toNamed(routeName, parameters: queryParams);
    // }
  }

  static void navigateWithGo(String destinationRoute,
      {Map<String, String>? queryParams}) {
    // // Construir la query string si hay parámetros
    // if (queryParams != null) {
    //   final query = queryParams.entries
    //       .map((e) =>
    //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    //       .join('&');
    //   // Usamos push() para actualizar tanto la URL como la pila de navegación
    //   Get.offAllNamed('$destinationRoute?$query');
    // } else {
    // Usamos push() para actualizar la URL y la pila de navegación
    Get.offNamed(destinationRoute, parameters: queryParams);
    // }
  }

  /// Retrocede a la ruta anterior.
  static void goBack() {
    final context = Get.key.currentState!;
    // Si se puede retroceder en la pila interna de navegación (canPop)

    if (context.canPop()) {
      // Retrocede en la pila interna de navegación
      Get.back();
    } else {
      // Si no se puede retroceder en la pila, redirige a la ruta HOME (si es necesario)
      Get.offAllNamed(Routes.HOME_PAGE);
    }
  }
}
