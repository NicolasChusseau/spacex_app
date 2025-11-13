import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/data/models/launch.model.dart';
import 'package:spacex_app/data/models/rocket.model.dart';
import 'package:spacex_app/data/api/rocket.service.dart';
import 'package:spacex_app/ui/cubit/favorites.state.dart';
import 'package:spacex_app/utils/DateHelper.dart';

import '../cubit/favorites.cubit.dart';
import '../widget/link_button.dart';

class LaunchDetailsPage extends StatelessWidget {
  const LaunchDetailsPage({
    super.key,
    required this.launch,
  });

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = launch.links?.patch?.large ??
        'https://via.placeholder.com/600x400.png?text=No+Image';
    final DateTime? date = launch.dateUtc;
    final String formattedDate = DateHelper.formatDate(date);
    final bool? success = launch.success;

    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFavorite = state.favoriteIds.contains(launch.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                tooltip: isFavorite ? "Retirer des favoris" : "Ajouter aux favoris",
                onPressed: () => context.read<FavoritesCubit>().toggleFavorite(context, launch.id),
              );
            },
          ),

        ],
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
                fit: BoxFit.contain,
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
              launch.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
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
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              launch.details ?? "Aucun détail disponible.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            FutureBuilder<Rocket>(
              future: RocketService.fetchRocket(launch.rocket),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return const SizedBox.shrink();
                }

                final Rocket? rocket = snapshot.data;
                if (rocket == null) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fusée',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Text(rocket.name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    if (rocket.type != null) Text(rocket.type!, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 12,
                      children: [
                        if (rocket.height != null) Text('Hauteur: ${rocket.height} m', style: Theme.of(context).textTheme.bodySmall),
                        if (rocket.diameter != null) Text('Diamètre: ${rocket.diameter} m', style: Theme.of(context).textTheme.bodySmall),
                        if (rocket.mass != null) Text('Masse: ${rocket.mass} kg', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 8),

                    if (rocket.description != null) ...[
                      Text('Description', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(rocket.description!, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                    const SizedBox(height: 8),

                    if (rocket.wikipedia != null)
                      GestureDetector(
                        onTap: () async {
                          try {
                            await Future.value();
                          } catch (_) {}
                        },
                        child: Text(
                          'Wikipedia',
                          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),

            if (launch.links != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Liens",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  LinkButton(
                    icon: Icons.ondemand_video,
                    text: "Webcast",
                    url: launch.links?.webcast,
                  ),
                  LinkButton(
                    icon: Icons.article,
                    text: "Article",
                    url: launch.links?.article,
                  ),
                  LinkButton(
                    icon: Icons.public,
                    text: "Wikipedia",
                    url: launch.links?.wikipedia,
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
