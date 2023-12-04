import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'deneb_DB.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE celestial_bodies(id INTEGER PRIMARY KEY, name TEXT, description TEXT, type TEXT, majorityNature TEXT, size REAL, distanceFromEarth REAL)",
        );
        db.execute(
          "CREATE TABLE celestial_body_photos(id INTEGER PRIMARY KEY, imagePath TEXT, celestialBodyId INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<void> deleteAllRecords() async {
    final db = await DBHelper.database();
    await db.delete('celestial_bodies');

    // Reset the ID counter
    await db.setVersion(1);
  }

  static Future<void> saveCelestialBody(CelestialBody celestialBody) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(
      'celestial_bodies',
      where: 'id = ?',
      whereArgs: [celestialBody.id],
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
      return CelestialBody.fromMap(maps[i]);
    });
  }

  static Future<void> saveCelestialBodyPhoto(
      CelestialBodyPhoto celestialBodyPhoto) async {
    final db = await DBHelper.database();
    await db.insert(
      'celestial_body_photos',
      celestialBodyPhoto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<CelestialBodyPhoto>> getCelestialBodyPhotos(int celestialBodyId) async {
    final db = await DBHelper.database();

    final List<Map<String, dynamic>> maps = await db.query(
      'celestial_body_photos',
      where: 'celestialBodyId = ?',
      whereArgs: [celestialBodyId],
    );

    return List.generate(maps.length, (i) {
      return CelestialBodyPhoto.fromMap(maps[i]);
    });
  }
}
