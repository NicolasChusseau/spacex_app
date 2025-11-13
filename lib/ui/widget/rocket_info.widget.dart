import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/rocket.model.dart';
import 'package:spacex_app/ui/widget/link_button.dart';

class RocketInfoWidget extends StatelessWidget {
  const RocketInfoWidget({
    super.key,
    required this.rocket,
  });

  final Rocket rocket;

  @override
  Widget build(BuildContext context) {
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
          LinkButton(
            icon: Icons.public,
            text: 'Wikipedia de la fusée',
            url: rocket.wikipedia,
          ),
        const SizedBox(height: 12),
      ],
    );
  }
}
