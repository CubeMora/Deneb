import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'celestial_bodies.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE celestial_bodies(id INTEGER PRIMARY KEY, name TEXT, description TEXT, type TEXT, majorityNature TEXT, size REAL, distanceFromEarth REAL, imagePath TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> saveCelestialBody(CelestialBody celestialBody) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(
      'celestial_bodies',
      where: 'name = ?',
      whereArgs: [celestialBody.name],
    );
    if (maps.isNotEmpty) {
      await db.update(
        'celestial_bodies',
        celestialBody.toMap(),
        where: 'name = ?',
        whereArgs: [celestialBody.name],
      );
    } else {
      await db.insert(
        'celestial_bodies',
        celestialBody.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<CelestialBody>> getCelestialBodies() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('celestial_bodies');
    return List.generate(maps.length, (i) {
      return CelestialBody(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        type: maps[i]['type'],
        majorityNature: maps[i]['majorityNature'],
        size: maps[i]['size'],
        distanceFromEarth: maps[i]['distanceFromEarth'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }
}
