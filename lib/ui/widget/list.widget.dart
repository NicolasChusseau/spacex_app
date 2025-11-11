import 'package:flutter/material.dart';

import '../../data/models/lunch.model.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.lunches,
  });

  final List<Lunch> lunches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: lunches.length,
      itemBuilder: (BuildContext context, int index) {
        final Lunch lunch = lunches[index];
        final String title = lunch.name;
        final DateTime date = lunch.dateUtc ?? DateTime(0);

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
