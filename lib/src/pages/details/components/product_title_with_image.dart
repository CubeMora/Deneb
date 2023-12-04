import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';
class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.celestialBody});

  final CelestialBody celestialBody;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Padding(
        padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.1)),
        child: Row(
          children: <Widget>[
            const SizedBox(width: kDefaultPaddin),
            Expanded(
              child: Image.asset(
                
                celestialBody.image, 
                width:( MediaQuery.of(context).size.width * 0.1) ,
                height: (MediaQuery.of(context).size.height * 0.4) ,
                fit: BoxFit.contain,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
