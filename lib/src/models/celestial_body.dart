// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CelestialBody {
  final int? id;
  final String name;
  final String description;
  final String type;
  final String majorityNature;
  final double size;
  final double distanceFromEarth;
  final String imagePath;

  CelestialBody({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.majorityNature,
    required this.size,
    required this.distanceFromEarth, 
    required this.imagePath,
  });


  CelestialBody copyWith({
    int? id,
    String? name,
    String? description,
    String? type,
    String? majorityNature,
    double? size,
    double? distanceFromEarth,
    String? imagePath,
  }) {
    return CelestialBody(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      majorityNature: majorityNature ?? this.majorityNature,
      size: size ?? this.size,
      distanceFromEarth: distanceFromEarth ?? this.distanceFromEarth,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'majorityNature': majorityNature,
      'size': size,
      'distanceFromEarth': distanceFromEarth,
      'imagePath': imagePath,
    };
  }

  factory CelestialBody.fromMap(Map<String, dynamic> map) {
    return CelestialBody(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      majorityNature: map['majorityNature'] as String,
      size: map['size'] as double,
      distanceFromEarth: map['distanceFromEarth'] as double,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialBody.fromJson(String source) => CelestialBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CelestialBody(id: $id, name: $name, description: $description, type: $type, majorityNature: $majorityNature, size: $size, distanceFromEarth: $distanceFromEarth, imagePath: $imagePath)';
  }

  @override
  bool operator ==(covariant CelestialBody other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.type == type &&
      other.majorityNature == majorityNature &&
      other.size == size &&
      other.distanceFromEarth == distanceFromEarth &&
      other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      type.hashCode ^
      majorityNature.hashCode ^
      size.hashCode ^
      distanceFromEarth.hashCode ^
      imagePath.hashCode;
  }
}
