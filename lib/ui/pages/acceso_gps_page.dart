import 'package:flutter/material.dart';
import 'package:flutter_mapa/core/route/app_router.dart';
import 'package:flutter_mapa/core/services/natigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({super.key});

  @override
  State<AccesoGpsPage> createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  /// Método que se llama cuando el objeto State se inserta en el árbol de widgets.
  ///
  /// Este método agrega el objeto actual como observador de los cambios en el ciclo de vida del widget.
  /// Es importante llamar a `super.initState()` para asegurar que el estado del widget se inicialice correctamente.
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

  /// Método que se llama cuando el estado del ciclo de vida de la aplicación cambia.
  ///
  /// Este método verifica si la aplicación ha vuelto al estado `resumed` (reanudado).
  /// Si el permiso de ubicación está concedido, navega a la página de carga.
  ///
  /// @param state El nuevo estado del ciclo de vida de la aplicación.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        NavigationServices.navigateWithGo(Routes.REGISTER);
      }
    }
  }

  /// Construye la interfaz de usuario para la página de acceso al GPS.
  ///
  /// Este widget muestra un mensaje indicando que es necesario el GPS para usar la aplicación
  /// y un botón para solicitar el acceso al GPS. Cuando se presiona el botón, se solicita el
  /// permiso de ubicación y se llama a la función `accesoGps` con el estado del permiso.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Es necesario el GPS para usar esta aplicación'),
          MaterialButton(
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            onPressed: () async {
              final status = await Permission.location.request();

              accesoGps(status);
            },
            child: const Text('Solicitar acceso',
                style: TextStyle(color: Colors.white)),
          )
        ],
      )),
    );
  }

  /// Maneja el estado del permiso de acceso al GPS.
  ///
  /// Dependiendo del estado del permiso, realiza diferentes acciones:
  ///
  /// - [PermissionStatus.granted]: Navega a la página del mapa.
  /// - [PermissionStatus.denied], [PermissionStatus.restricted], [PermissionStatus.permanentlyDenied]: Abre la configuración de la aplicación.
  ///
  /// Parámetros:
  /// - [status]: El estado del permiso de acceso al GPS.
  void accesoGps(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        NavigationServices.navigateWithGo(Routes.REGISTER);
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
    }
  }
}
