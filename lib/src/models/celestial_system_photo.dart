// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter_app_astronomy/src/models/celestial_system.dart';

class CelestialSystemPhoto {

  final int? id;
  final String imagePath;
  final CelestialSystem celestialSystem;
  
  CelestialSystemPhoto({
    this.id,
    required this.imagePath,
    required this.celestialSystem,
  });


  CelestialSystemPhoto copyWith({
    int? id,
    String? imagePath,
    CelestialSystem? celestialSystem,
  }) {
    return CelestialSystemPhoto(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      celestialSystem: celestialSystem ?? this.celestialSystem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imagePath': imagePath,
      'celestialSystem': celestialSystem.toMap(),
    };
  }

  factory CelestialSystemPhoto.fromMap(Map<String, dynamic> map) {
    return CelestialSystemPhoto(
      id: map['id'] != null ? map['id'] as int : null,
      imagePath: map['imagePath'] as String,
      celestialSystem: CelestialSystem.fromMap(map['celestialSystem'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialSystemPhoto.fromJson(String source) => CelestialSystemPhoto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CelestialSystemPhoto(id: $id, imagePath: $imagePath, celestialSystem: $celestialSystem)';

  @override
  bool operator ==(covariant CelestialSystemPhoto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.imagePath == imagePath &&
      other.celestialSystem == celestialSystem;
  }

  @override
  int get hashCode => id.hashCode ^ imagePath.hashCode ^ celestialSystem.hashCode;
}
