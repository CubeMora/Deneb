import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  () {
                    switch (celestialBody.majorityNature) {
                      case "Rock":
                        return LineIcons.mountain;
                      case "Solid":
                        return LineIcons.hockeyPuck;
                      case "Liquid":
                        return LineIcons.water;
                      case "Gas":
                        return LineIcons.smog;
                      default:
                        return Icons.help;
                    }
                  }(),
                ),
              ),
              Text(celestialBody.majorityNature),
              const Spacer(),
              IconButton(
                icon: SvgPicture.asset(ImageConstant.svgBxPlanetBlack900),
                onPressed: () {},
              ),
              Text("${celestialBody.size.toString()} KM")
            ]),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      () {
                        switch (celestialBody.type) {
                          case "System":
                            return LineIcons.share;
                          case "Star":
                            return LineIcons.star;
                          case "Planet":
                            return LineIcons.globe;
                          case "Asteroid":
                            return LineIcons.cogs;
                          case "Comet":
                            return LineIcons.meteor;
                          case "Moon":
                            return LineIcons.moon;
                          case "Unknown":
                            return LineIcons.question;
                          default:
                            return Icons.help;
                        }
                      }(),
                    ),
                  ),
                  Text(celestialBody.type),
              ],
            ),
      ],
    );
  }
}
