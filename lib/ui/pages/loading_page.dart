import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  /// Método que se llama cuando el objeto del estado se inserta en el árbol.
  ///
  /// Este método agr ega el objeto actual como un observador de `WidgetsBinding`.
  /// Es importante llamar a`super.initState()` para asegurarse de que el
  /// estado del widget se inicialice correctamente.
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Método que se llama cuando cambia el estado del ciclo de vida de la aplicación.
  ///
  /// Este método se ejecuta de forma asíncrona y verifica si el estado de la aplicación
  /// ha cambiado a `resumed`. Si es así, comprueba si el servicio de ubicación está habilitado.
  /// Si el servicio de ubicación está habilitado, navega a la pantalla de autenticación.
  ///
  /// Parámetros:
  /// - `state`: El nuevo estado del ciclo de vida de la aplicación.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        NavigationServices.navigateWithGo(Routes.HOME_PAGE);
      }
    }
  }

  /// Construye un widget que muestra una pantalla de carga mientras se verifica
  /// el estado del GPS y la ubicación. Utiliza un `FutureBuilder` para manejar
  /// el estado asincrónico de la verificación.
  ///
  /// El `FutureBuilder` espera a que el `future` `chekGpsAndLocation` se complete.
  /// Mientras el `future` está en proceso, se muestra un `CircularProgressIndicator`.
  /// Una vez que el `future` se completa, se muestra el resultado en un `Text` widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: chekGpsAndLocation(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(snapshot.data.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  /// Verifica los permisos de GPS y el estado del servicio de ubicación.
  ///
  /// Esta función comprueba si la aplicación tiene permisos para acceder a la ubicación
  /// y si el servicio de GPS está activo. Dependiendo de estas condiciones, navega a diferentes
  /// pantallas o devuelve mensajes específicos.
  ///
  ///
  /// - Devuelve:
  ///   - Una cadena vacía si los permisos de GPS están concedidos y el GPS está activo.
  ///   - 'Page AccesoGpsPage' si los permisos de GPS no están concedidos.
  ///   - 'Active el GPS' si el GPS no está activo.
  ///
  /// - Navegación:
  ///   - Navega a `AuthScreen` si los permisos de GPS están concedidos y el GPS está activo.
  ///   - Navega a `AccesoGpsPage` si los permisos de GPS no están concedidos.
  Future chekGpsAndLocation(BuildContext context) async {
    //*: GPS Permission
    final permisoGps = await Permission.location.isGranted;
    //*: GPS Active
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisoGps && gpsActivo) {
      NavigationServices.navigateWithGo(Routes.REGISTER);
      return '';
    } else if (!permisoGps) {
      NavigationServices.navigateWithGo(Routes.ACCESO_GPS);
      return 'Page AccesoGpsPage';
    } else if (!gpsActivo) {
      return 'Active el GPS';
    }

    // Tiempo de espera para simular una carga
    await Future.delayed(const Duration(seconds: 1));

    // Navigator.pushReplacement(context, navegarMapaFadeIn(context, const AccesoGpsPage()));
  }
}
