import 'package:flutter/material.dart';
import 'package:flutter_mapa/ui/helpers/helpers.dart';
import 'package:flutter_mapa/ui/pages/acceso_gps_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mapa_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

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
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, const MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chekGpsAndLocation(context),
       builder: (BuildContext context,AsyncSnapshot snapshot) {
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

  Future chekGpsAndLocation(BuildContext context) async {
    //*: GPS Permission
    final permisoGps = await Permission.location.isGranted;
    //*: GPS Active
    final gpsActivo = await Geolocator.isLocationServiceEnabled();


    if (permisoGps && gpsActivo) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, const MapaPage()));
      return '';
    } else if (!permisoGps) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, const AccesoGpsPage()));
      return 'Page AccesoGpsPage';
    } else if (!gpsActivo) {
      return 'Active el GPS';
    }

    await Future.delayed(const Duration(seconds: 1));

    // Navigator.pushReplacement(context, navegarMapaFadeIn(context, const AccesoGpsPage()));
  }
}