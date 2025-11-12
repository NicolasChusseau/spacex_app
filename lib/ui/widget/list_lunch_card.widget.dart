import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/launch.model.dart';
import '../../utils/DateHelper.dart';
import '../cubit/favorites.cubit.dart';
import '../cubit/favorites.state.dart';
import '../pages/launch_details.page.dart';

class ListLunchCardWidget extends StatelessWidget {
  const ListLunchCardWidget({
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
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey[200],
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              success == true ? Icons.check_circle : Icons.cancel,
              color: success == true ? Colors.green : Colors.redAccent,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),

        subtitle: Text(formattedDate),
        trailing: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state.favoriteIds.contains(launch.id);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              tooltip: isFavorite
                  ? "Retirer des favoris"
                  : "Ajouter aux favoris",
              onPressed: () =>
                  context.read<FavoritesCubit>().toggleFavorite(context, launch.id),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaunchDetailsPage(launch: launch),
            ),
          );
        },
      ),
    );
  }
}
