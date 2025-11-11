import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/lunch.model.dart';

import '../widget/link_button.dart';

class LunchDetailsPage extends StatelessWidget {

  const LunchDetailsPage({
    super.key,
    required this.lunch
  });

  final Lunch lunch;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = lunch.links?.patch?.large ??
        'https://via.placeholder.com/600x400.png?text=No+Image';

    final DateTime? date = lunch.dateUtc;
    final String formattedDate = date != null
        ? date.toString()
        : 'Date inconnue';

    final bool? success = lunch.success;

    return Scaffold(
      appBar: AppBar(
        title: Text(lunch.name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 68),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              lunch.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  success == true ? Icons.check_circle : Icons.cancel,
                  color: success == true ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  success == true
                      ? 'Mission réussie'
                      : success == false
                      ? 'Échec'
                      : 'Statut inconnu',
                  style: TextStyle(
                    color: success == true
                        ? Colors.green[700]
                        : Colors.red[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "Détails de la mission",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              lunch.details ?? "Aucun détail disponible.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            if (lunch.links != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Liens",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LinkButton(
                    icon: Icons.ondemand_video,
                    text: "Webcast",
                    url: lunch.links?.webcast,
                  ),
                  LinkButton(
                    icon: Icons.article,
                    text: "Article",
                    url: lunch.links?.article,
                  ),
                  LinkButton(
                    icon: Icons.public,
                    text: "Wikipedia",
                    url: lunch.links?.wikipedia,
                  ),
                ],
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
