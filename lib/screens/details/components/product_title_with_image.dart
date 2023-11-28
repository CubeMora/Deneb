import 'package:flutter/material.dart';
import 'package:denep_app/models/Planet.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.planet});

  final Planet planet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: kDefaultPaddin),
                Expanded(
                  child: Hero(
                    tag: "${planet.id}",
                    child: Image.asset(
                      planet.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
