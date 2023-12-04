import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';


class Description extends StatelessWidget {
  const Description({super.key, required this.celestialBody});

  final CelestialBody celestialBody;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        celestialBody.description,
        style: const TextStyle(height: 1.5),
      ),
    );
  }
}
