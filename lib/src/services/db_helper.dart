import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();


    return openDatabase(
      join(dbPath, 'deneb_DB.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE celestial_bodies(id INTEGER PRIMARY KEY, name TEXT, description TEXT, image TEXT, type TEXT, majorityNature TEXT, size REAL, distanceFromEarth REAL, color INTEGER, systemId REAL, isUserPhoto INTEGER)",
        );

        db.execute(
          "CREATE TABLE celestial_body_photos(id INTEGER PRIMARY KEY, imagePath TEXT, celestialBodyId INTEGER)",
        );

        db.execute(
          "CREATE TABLE celestial_system(id INTEGER PRIMARY KEY, name TEXT, image TEXT)",
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

  static Future<bool> saveCelestialBody(CelestialBody celestialBody) async {
    try {
      final db = await database();
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

      return true;
    } catch (error) {
      print('Error al guardar en la base de datos: $error');
      return false;
    }
  }

  static Future<bool> saveCelestialSystem(
      CelestialSystem celestialSystem) async {
    final db = await DBHelper.database();
    final int id = await db.insert(
      'celestial_system',
      {
        'id': celestialSystem.id,
        'name': celestialSystem.name,
        'image': celestialSystem.image
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id != null && id > 0;
  }

  static Future<List<CelestialSystem>> getCelestialSystem(int id) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(
      'celestial_system',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return [
        CelestialSystem.fromMap(maps.first)
      ]; 
    }

    throw Exception('ID $id not found');
  }

  static Future<List<CelestialSystem>> getAllCelestialSystems() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('celestial_system');

    return List.generate(maps.length, (i) {
      return CelestialSystem.fromMap(maps[i]);
    });
  }

  static Future<void> insertCelestialBody(CelestialBody celestialBody) async {
    final db = await DBHelper.database();
    await db.insert(
      'celestial_bodies',
      celestialBody.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<CelestialBody>> getCelestialBodies(int systemId,
      {String type = ''}) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(
      'celestial_bodies',
      where: type.isEmpty ? 'systemId = ?' : 'systemId = ? AND type = ?',
      whereArgs: type.isEmpty ? [systemId] : [systemId, type],
    );

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

  static Future<List<CelestialBodyPhoto>> getCelestialBodyPhotos(
      int celestialBodyId) async {
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
