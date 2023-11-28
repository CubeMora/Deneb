import 'package:flutter/material.dart';
import 'package:denep_app/models/Planet.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.planet});

  final Planet planet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        planet.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
