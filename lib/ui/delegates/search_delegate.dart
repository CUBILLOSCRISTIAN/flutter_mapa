import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SearchDelegateClass extends SearchDelegate {

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
      onPressed: () => close(context, null),
    );
  }

  //Sugerencias que aparecen cuando la persona escribe
  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults...');
  }

  //Sugerencias que aparecen cuando la persona escribe
  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('BuildSuggestions...');
  }
}
