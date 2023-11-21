// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';

class CelestialSystem {
  final int id;
  final String name;
  final List<CelestialBody> celestialBodies;

  CelestialSystem({
    required this.id,
    required this.name,
    required this.celestialBodies,
  });

  CelestialSystem copyWith({
    int? id,
    String? name,
    List<CelestialBody>? celestialBodies,
  }) {
    return CelestialSystem(
      id: id ?? this.id,
      name: name ?? this.name,
      celestialBodies: celestialBodies ?? this.celestialBodies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'celestialBodies': celestialBodies.map((x) => x.toMap()).toList(),
    };
  }

  factory CelestialSystem.fromMap(Map<String, dynamic> map) {
    return CelestialSystem(
      id: map['id'] as int,
      name: map['name'] as String,
      celestialBodies: List<CelestialBody>.from(
        (map['celestialBodies'] as List<int>).map<CelestialBody>(
          (x) => CelestialBody.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialSystem.fromJson(String source) =>
      CelestialSystem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CelestialSystem(id: $id, name: $name, celestialBodies: $celestialBodies)';

  @override
  bool operator ==(covariant CelestialSystem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.celestialBodies, celestialBodies);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ celestialBodies.hashCode;
}
