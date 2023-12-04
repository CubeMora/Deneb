import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

import 'package:flutter_svg/svg.dart';

class Characteristics extends StatelessWidget {
  const Characteristics({super.key, required this.celestialBody});

  final CelestialBody celestialBody;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
            heightFactor: 0.5,
            alignment: Alignment.centerLeft,
            child: Text(celestialBody.name,
                style: theme.textTheme.headlineMedium)),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(celestialBody.majorityNature),
              const Spacer(),
              IconButton(
                icon: SvgPicture.asset(ImageConstant.svgBxPlanetBlack900),
                onPressed: () {},
              ),
              Text("${celestialBody.size.toString()} KM")
            ]),
      ],
    );
  }
}
