// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_app_astronomy/src/models/celestial_body.dart';

class CelestialSystem {
  final int? id;
  final String name;
  final String image;
  CelestialSystem({
    this.id,
    required this.name,
    required this.image,
  });

  CelestialSystem copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return CelestialSystem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory CelestialSystem.fromMap(Map<String, dynamic> map) {
    return CelestialSystem(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialSystem.fromJson(String source) =>
      CelestialSystem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CelestialSystem(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(covariant CelestialSystem other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
