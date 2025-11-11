import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/lunch.model.dart';

import '../pages/lunch_details.page.dart';

class GridLunchCardWidget extends StatelessWidget {
  const GridLunchCardWidget({
    super.key,
    required this.lunch,
  });

  final Lunch lunch;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = lunch.links?.patch?.small ??
        'https://via.placeholder.com/150?text=No+Image';
    final String title = lunch.name;
    final bool? success = lunch.success;
    final DateTime? date = lunch.dateUtc;

    final String formattedDate = date != null
        ? date.toString()
        : 'Date inconnue';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LunchDetailsPage(lunch: lunch)
            )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(imageUrl)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 4),

                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(
                        success == true
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: success == true
                            ? Colors.green
                            : Colors.redAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        success == true ? 'Succès' : 'Échec',
                        style: TextStyle(
                          color: success == true
                              ? Colors.green[700]
                              : Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
