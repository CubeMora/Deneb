import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';

// ignore: must_be_immutable
class HomepageItemWidget extends StatelessWidget {
  const HomepageItemWidget({
    super.key,
    required this.celestialBody,
  });
  final CelestialBody celestialBody;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 9,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  celestialBody.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              celestialBody.name,
            ),
          ],
        ),
      ),
    );
  }
}
