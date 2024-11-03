import 'package:flutter/material.dart';
import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

class SearchItemPOI extends StatelessWidget {
  final PointOfInterest poi;

  const SearchItemPOI({
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
          
        },
      ),
    );
  }
}
