import 'package:flutter/material.dart';
import 'package:flutter_mapa/domain/models/POIs/point_of_interest.dart';

class SearchItemPOI extends StatelessWidget {
  final PointOfInterest poi;

  final Function onSelected;

  const SearchItemPOI({
    super.key,
    required this.poi,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onSelected(context,poi);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(poi.imageURL)),
            ),
            const SizedBox(
              width: 10,
            ),
            //Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poi.name,
                    style: textStyle.titleMedium,
                  ),
                  Text(
                    poi.description,
                    style: textStyle.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        poi.openingHours,
                        style: textStyle.bodySmall
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //Icon for hours
          ],
        ),
      ),
    );
  }
}
