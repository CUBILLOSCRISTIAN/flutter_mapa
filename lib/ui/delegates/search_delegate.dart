import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

// Esto es un contrato que se va a cumplir en el widget que se va a implementar
// Cualquier funcion que cumpla con este contrato puede ser utilizada en el widget
typedef SearchPOICallback = Future<List<PointOfInterest>> Function(String text);

List<PointOfInterest> poisVisited = [];

class SearchDelegateClass extends SearchDelegate {
  final SearchPOICallback searchPOI;

  //Para no hacer peticiones cada que user escriba
  StreamController<List<PointOfInterest>> debouncedPOI =
      StreamController.broadcast();

  Timer? _debounceTimer;

  SearchDelegateClass({
    required this.searchPOI,
  });

  void clearStream() {
    debouncedPOI.close();
  }

  void onQueryChange(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        final List<PointOfInterest> pois = await searchPOI(query);
        debouncedPOI.add(pois);
      }
    });
  }

  @override
  String get searchFieldLabel => 'Buscar un lugar de la U';

  //
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => query = '',
          ))
    ];
  }

  //IzqTop icono de regreso
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        clearStream();
        close(context, null);
      },
    );
  }

  //Sugerencias que aparecen cuando la persona escribe
  @override
  Widget buildResults(BuildContext context) {
    return Builder(builder: (context) {
      return ListView.builder(
        itemCount: poisVisited.length,
        itemBuilder: (context, index) {
          final PointOfInterest poi = poisVisited[index];
          return CardItemSearch(
            poi: poi,
          );
        },
      );
    });
  }

  //Sugerencias que aparecen
  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChange(query);
    return StreamBuilder(
        // future: searchPOI(query),
        stream: debouncedPOI.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PointOfInterest> pois = snapshot.data!;

            return ListView.builder(
              itemCount: pois.length,
              itemBuilder: (context, index) {
                final PointOfInterest poi = pois[index];
                return CardItemSearch(
                  poi: poi,
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class CardItemSearch extends StatelessWidget {
  final PointOfInterest poi;

  const CardItemSearch({
    super.key,
    required this.poi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.place, color: Theme.of(context).primaryColor),
        title: Text(
          poi.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(poi.description),
        onTap: () {
          poisVisited.add(poi);
        },
      ),
    );
  }
}
