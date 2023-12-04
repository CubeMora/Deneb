import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';


class ItemCard extends StatelessWidget {
  const ItemCard({super.key,  required this.press, required this.celestialBody});

  final CelestialBody celestialBody;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: celestialBody.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${celestialBody.id}",
                child: Image.asset(celestialBody.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              celestialBody.name,
              style: const TextStyle(color: kTextLightColor),
            ),
          )
        ],
      ),
    );
  }
}
