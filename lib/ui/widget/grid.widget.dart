import 'package:flutter/material.dart';

import '../../data/models/launch.model.dart';
import 'grid_launch_card.widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.launches,
  });

  final List<Launch> launches;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ) +
          EdgeInsets.only(
            bottom: MediaQuery
                .paddingOf(context)
                .bottom,
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        // Ce ratio influence la manière dont l'espace est réparti
        // entre les dimensions horizontale et verticale.
        // Exemple :
        //  - Un ratio de 0.5, le widget [PokemonCardWidget] sera deux fois
        // plus haut que large.
        //  - Un ratio de 2, le widget [PokemonCardWidget] sera deux fois
        // plus large que haut.
        childAspectRatio: 1,
      ),
      itemCount: launches.length,
      itemBuilder: (BuildContext context, int index) {
        final Launch launch = launches.elementAt(index);
        return GridLaunchCardWidget(launch: launch);
      });
  }
}
