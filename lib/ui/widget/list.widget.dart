import 'package:flutter/material.dart';

import '../../data/models/launch.model.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.launches,
  });

  final List<Launch> launches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: launches.length,
      itemBuilder: (BuildContext context, int index) {
        final Launch launch = launches[index];
        final String title = launch.name;
        final DateTime date = launch.dateUtc ?? DateTime(0);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                title.isNotEmpty ? title[0].toUpperCase() : '?',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Date: $date'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // action au tap si nécessaire
            },
          ),
        );
      },
    );
  }
}
