import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({super.key});

  @override
  State<AccesoGpsPage> createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver{


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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
              child: const Text('Solicitar acceso', style:  TextStyle(color: Colors.white)),
            )
          ],
        )
      ),
    );
  }

  void accesoGps(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
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