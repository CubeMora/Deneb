import 'package:flutter/material.dart';
import 'package:denep_app/models/Planet.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.planet, required this.press});

  final Planet planet;
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
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: planet.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${planet.id}",
                child: Image.asset(planet.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              planet.title,
              style: TextStyle(color: kTextLightColor),
            ),
          )
        ],
      ),
    );
  }
}
