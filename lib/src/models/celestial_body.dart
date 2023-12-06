// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class CelestialBody {
  final int? id;
  final String name;
  final String description;
  final String image;
  final String type;
  final String majorityNature;
  final int size;
  final int distanceFromEarth;
  final Color color;
  final int systemId;
  final bool isUserPhoto;
  CelestialBody({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.type,
    required this.majorityNature,
    required this.size,
    required this.distanceFromEarth,
    required this.color,
    required this.systemId,
    required this.isUserPhoto,
  });

  CelestialBody copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? type,
    String? majorityNature,
    int? size,
    int? distanceFromEarth,
    Color? color,
    int? systemId,
    bool? isUserPhoto,
  }) {
    return CelestialBody(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      type: type ?? this.type,
      majorityNature: majorityNature ?? this.majorityNature,
      size: size ?? this.size,
      distanceFromEarth: distanceFromEarth ?? this.distanceFromEarth,
      color: color ?? this.color,
      systemId: systemId ?? this.systemId,
      isUserPhoto: isUserPhoto ?? this.isUserPhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'type': type,
      'majorityNature': majorityNature,
      'size': size,
      'distanceFromEarth': distanceFromEarth,
      'color': color.value,
      'systemId': systemId,
      'isUserPhoto': isUserPhoto,
    };
  }

  factory CelestialBody.fromMap(Map<String, dynamic> map) {
    return CelestialBody(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      type: map['type'] as String,
      majorityNature: map['majorityNature'] as String,
      size: map['size'] is double ? map['size'].toInt() : map['size'],
      distanceFromEarth: map['distanceFromEarth'] is double
          ? map['distanceFromEarth'].toInt()
          : map['distanceFromEarth'],
      color: Color(map['color'] as int),
      systemId:
          map['systemId'] is double ? map['systemId'].toInt() : map['systemId'],
      isUserPhoto:
          map['isUserPhoto'] == 1 ? true : false, // Convert int to bool
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialBody.fromJson(String source) =>
      CelestialBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CelestialBody(id: $id, name: $name, description: $description, image: $image, type: $type, majorityNature: $majorityNature, size: $size, distanceFromEarth: $distanceFromEarth, color: $color, systemId: $systemId, isUserPhoto: $isUserPhoto)';
  }

  @override
  bool operator ==(covariant CelestialBody other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.type == type &&
        other.majorityNature == majorityNature &&
        other.size == size &&
        other.distanceFromEarth == distanceFromEarth &&
        other.color == color &&
        other.systemId == systemId &&
        other.isUserPhoto == isUserPhoto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        type.hashCode ^
        majorityNature.hashCode ^
        size.hashCode ^
        distanceFromEarth.hashCode ^
        color.hashCode ^
        systemId.hashCode ^
        isUserPhoto.hashCode;
  }
}
