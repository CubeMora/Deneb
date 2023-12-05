

import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

class LocalData {

   Future<List<CelestialBody>> get celestialBodyList async {
   final db = await DBHelper.database();
   final List<Map<String, dynamic>> maps = await db.query('celestial_bodies');
   return List.generate(maps.length, (i) {
     return CelestialBody.fromMap(maps[i]);
   });
 }

 Future<void> insertDefaultCelestialBodies() async {
  List<CelestialBody> celestialBodyList2 = [
    CelestialBody(id: 1, name: "Mars", description: "Rocky red thingy", image: ImageConstant.imgCard,type: "Planet", majorityNature: "Rock", size: 1213132, distanceFromEarth: 1, color: Colors.orange),
    CelestialBody(id: 2, name: "Luna", description: "Cheesy", type: "Moon", image: ImageConstant.gifKram,majorityNature: "Gas", size: 10, distanceFromEarth: 0.1, color: Colors.lightBlue),
    CelestialBody(id: 3, name: "Venus", description: "Earth element related for some reason", image: ImageConstant.imgChochi ,type: "Comet", majorityNature: "Liquid", size: 1000.3, distanceFromEarth: 23, color: Colors.lightGreen)
  ];

  for (CelestialBody celestialBody in celestialBodyList2) {
    await DBHelper.insertCelestialBody(celestialBody);
  }
 }

  List<CelestialBody> celestialBodyListForSection = [
    CelestialBody(id: 1, name: "Mars", description: "Rocky red thingy", image: ImageConstant.imgCard,type: "Planet", majorityNature: "Rock", size: 1213132, distanceFromEarth: 1, color: Colors.orange),
    CelestialBody(id: 2, name: "Luna", description: "Cheesy", type: "Moon", image: ImageConstant.gifKram,majorityNature: "Gas", size: 10, distanceFromEarth: 0.1, color: Colors.lightBlue),
    CelestialBody(id: 3, name: "Venus", description: "Earth element related for some reason", image: ImageConstant.imgChochi ,type: "Comet", majorityNature: "Liquid", size: 1000.3, distanceFromEarth: 23, color: Colors.lightGreen)
  ];


}