import 'package:flutter/material.dart';
import '../../data/models/launch.model.dart';
import 'list_lunch_card.widget.dart';

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
        return ListLunchCardWidget(launch: launch);
      },
    );
  }
}
