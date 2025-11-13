import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/data/models/launch.model.dart';

import '../../utils/DateHelper.dart';
import '../cubit/favorites.cubit.dart';
import '../cubit/favorites.state.dart';
import '../pages/launch_details.page.dart';

class GridLaunchCardWidget extends StatelessWidget {
  const GridLaunchCardWidget({
    super.key,
    required this.launch,
  });

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = launch.links?.patch?.small ??
        'https://via.placeholder.com/150?text=No+Image';
    final String title = launch.name;
    final bool? success = launch.success;
    final DateTime? date = launch.dateUtc;
    final String formattedDate = DateHelper.formatDate(date);

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
              builder: (context) => LaunchDetailsPage(launch: launch),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

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

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            success == true ? Icons.check_circle : Icons.cancel,
                            color: success == true ? Colors.green : Colors.redAccent,
                            size: 18,
                          )
                        ],
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
