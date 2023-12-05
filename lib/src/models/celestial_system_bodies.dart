// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CelestialSystemBodies {
  final int idSystem;
  final int idBody;
  CelestialSystemBodies({
    required this.idSystem,
    required this.idBody,
  });

  CelestialSystemBodies copyWith({
    int? idSystem,
    int? idBody,
  }) {
    return CelestialSystemBodies(
      idSystem: idSystem ?? this.idSystem,
      idBody: idBody ?? this.idBody,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSystem': idSystem,
      'idBody': idBody,
    };
  }

  factory CelestialSystemBodies.fromMap(Map<String, dynamic> map) {
    return CelestialSystemBodies(
      idSystem: map['idSystem'] as int,
      idBody: map['idBody'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CelestialSystemBodies.fromJson(String source) =>
      CelestialSystemBodies.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CelestialSystemBodies(idSystem: $idSystem, idBody: $idBody)';

  @override
  bool operator ==(covariant CelestialSystemBodies other) {
    if (identical(this, other)) return true;

    return other.idSystem == idSystem && other.idBody == idBody;
  }

  @override
  int get hashCode => idSystem.hashCode ^ idBody.hashCode;
}
