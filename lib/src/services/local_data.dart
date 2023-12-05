import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system_bodies.dart';
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
        id: 1, name: "Milky Way DX", image: ImageConstant.gifKram);
    final CelestialSystem cdei2 = CelestialSystem(
        id: 2, name: "Kramdomeda", image: ImageConstant.gifKram);

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
          systemId: 1),
      CelestialBody(
          id: 2,
          name: "Luna",
          description: "Cheesy",
          type: "Moon",
          image: ImageConstant.gifKram,
          majorityNature: "Gas",
          size: 10,
          distanceFromEarth: 1,
          color: Colors.lightBlue,
          systemId: 1),
      CelestialBody(
          id: 3,
          name: "Venus",
          description: "Earth element related for some reason",
          image: ImageConstant.imgChochi,
          type: "Comet",
          majorityNature: "Liquid",
          size: 1000,
          distanceFromEarth: 23,
          color: Colors.lightGreen,
          systemId: 1)
    ];

    for (CelestialBody celestialBody in celestialBodyList2) {
      await DBHelper.insertCelestialBody(celestialBody);
    }

    DBHelper.saveCelestialSystem(cdei);
    DBHelper.saveCelestialSystem(cdei2);

    // DBHelper.saveCelestialSystemBodies(CelestialSystemBodies(
    //     idSystem: cdei.id!, idBody: celestialBodyList2[1].id!));

    final chochi = await DBHelper.getCelestialSystem(cdei.id!);
    final chochi2 = await DBHelper.getCelestialSystem(cdei2.id!);
    final felix = await DBHelper.getCelestialSystemBodies(2);

    print(
        "Celestial system: $chochi, Celestial System 2: $chochi2  \n Celestial System Bodies: $felix");
  }

  // List<CelestialBody> celestialBodyListForSection = [
  //   CelestialBody(
  //       id: 1,
  //       name: "Mars",
  //       description: "Rocky red thingy",
  //       image: ImageConstant.imgTierra,
  //       type: "Planet",
  //       majorityNature: "Rock",
  //       size: 1213132,
  //       distanceFromEarth: 1,
  //       color: Colors.orange),
  //   CelestialBody(
  //       id: 2,
  //       name: "Luna",
  //       description: "Cheesy",
  //       type: "Moon",
  //       image: ImageConstant.imgTierra,
  //       majorityNature: "Gas",
  //       size: 10,
  //       distanceFromEarth: 0.1,
  //       color: Colors.lightBlue),
  //   CelestialBody(
  //       id: 3,
  //       name: "Venus",
  //       description: "Earth element related for some reason",
  //       image: ImageConstant.imgTierra,
  //       type: "Comet",
  //       majorityNature: "Liquid",
  //       size: 1000.3,
  //       distanceFromEarth: 23,
  //       color: Colors.lightGreen)
  // ];
}
