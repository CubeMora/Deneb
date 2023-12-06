import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

class LocalData {
  Future<List<CelestialBody>> get celestialBodyList async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('celestial_bodies');
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(maps.length, (i) {
      return CelestialBody.fromMap(maps[i]);
    });
  }

  Future<void> insertDefaultCelestialBodies() async {
    final CelestialSystem cdei = CelestialSystem(
        id: 1, name: "Solar System", image: ImageConstant.imgSol);
    final CelestialSystem cdei2 = CelestialSystem(
        id: 2, name: "Kramdomeda", image: ImageConstant.gifKram);
    final CelestialSystem cdei3 = CelestialSystem(
        id: 3, name: "Milky Way Galaxy", image: ImageConstant.imgMilkyWay);


    List<CelestialBody> celestialBodyList2 = [
      CelestialBody(
          id: 1,
          name: "Mars",
          description: "Rocky red thingy",
          image: ImageConstant.imgCard,
          type: "Planet",
          majorityNature: "Rock",
          size: 1213132,
          distanceFromEarth: 1,
          color: Colors.orange,
          systemId: 1,
          isUserPhoto: false
          ),
      CelestialBody(
          id: 2,
          name: "Luna",
          description: "Cheesy",
          type: "Moon",
          image: ImageConstant.imgLuna,
          majorityNature: "Rock",
          size: 10,
          distanceFromEarth: 1,
          color: Colors.lightBlue,
          systemId: 1,
          isUserPhoto: false
          ),
      CelestialBody(
          id: 3,
          name: "Venus",
          description: "Earth element related for some reason",
          image: ImageConstant.imgVenus,
          type: "Planet",
          majorityNature: "Solid",
          size: 1000,
          distanceFromEarth: 23,
          color: Colors.lightGreen,
          systemId: 1,
          isUserPhoto: false
          
          )
    ];

    for (CelestialBody celestialBody in celestialBodyList2) {
      await DBHelper.insertCelestialBody(celestialBody);
    }

    DBHelper.saveCelestialSystem(cdei);
    DBHelper.saveCelestialSystem(cdei2);
    DBHelper.saveCelestialSystem(cdei3);

  }


}
