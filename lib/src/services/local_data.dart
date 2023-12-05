import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';

class LocalData {
  List<CelestialBody> get celestialBodyList => [
        CelestialBody(
            id: 1,
            name: "Mars",
            description: "Rocky red thingy",
            image: ImageConstant.imgCard,
            type: "Rocky",
            majorityNature: "Rock",
            size: 1213132,
            distanceFromEarth: 1,
            color: Colors.orange),
        CelestialBody(
            id: 2,
            name: "Luna",
            description: "Cheesy",
            type: "Rocky",
            image: ImageConstant.gifKram,
            majorityNature: "Rock",
            size: 10,
            distanceFromEarth: 0.1,
            color: Colors.lightBlue),
        CelestialBody(
            id: 3,
            name: "Venus",
            description: "Earth element related for some reason",
            image: ImageConstant.imgChochi,
            type: "Earthy",
            majorityNature: "Rock",
            size: 1000.3,
            distanceFromEarth: 23,
            color: Colors.lightGreen)
      ];
}
