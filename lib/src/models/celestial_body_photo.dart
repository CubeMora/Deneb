// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CelestialBodyPhoto {
  final int? id;
  final String imagePath;
  final int celestialBodyId;
  CelestialBodyPhoto({
    this.id,
    required this.imagePath,
    required this.celestialBodyId,
  });


  CelestialBodyPhoto copyWith({
    int? id,
    String? imagePath,
    int? celestialBodyId,
  }) {
    return CelestialBodyPhoto(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      celestialBodyId: celestialBodyId ?? this.celestialBodyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imagePath': imagePath,
      'celestialBodyId': celestialBodyId,
    };
  }

  factory CelestialBodyPhoto.fromMap(Map<String, dynamic> map) {
    return CelestialBodyPhoto(
      id: map['id'] != null ? map['id'] as int : null,
      imagePath: map['imagePath'] as String,
      celestialBodyId: map['celestialBodyId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialBodyPhoto.fromJson(String source) => CelestialBodyPhoto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CelestialBodyPhoto(id: $id, imagePath: $imagePath, celestialBodyId: $celestialBodyId)';

  @override
  bool operator ==(covariant CelestialBodyPhoto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.imagePath == imagePath &&
      other.celestialBodyId == celestialBodyId;
  }

  @override
  int get hashCode => id.hashCode ^ imagePath.hashCode ^ celestialBodyId.hashCode;
}
