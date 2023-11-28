import 'package:flutter/material.dart';
import 'package:denep_app/models/Planet.dart';
import 'package:denep_app/theme_helper.dart';
import 'package:denep_app/image_constant.dart';
import 'package:flutter_svg/svg.dart';

class Characteristics extends StatelessWidget {
  const Characteristics({super.key, required this.planet});

  final Planet planet;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
            heightFactor: 0.5,
            alignment: Alignment.centerLeft,
            child: Text(planet.title, style: theme.textTheme.headlineMedium)),
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("GAS"),
              Spacer(),
              IconButton(
                icon: SvgPicture.asset(ImageConstant.imgBxPlanetBlack900),
                onPressed: () {},
              ),
              Text(
                "142.980 KM",
              )
            ]),
      ],
    );
  }
}
