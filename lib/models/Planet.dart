import 'package:flutter/material.dart';
import 'package:denep_app/image_constant.dart';

class Planet {
  final String image, title, description;
  final int size, id;
  final Color color;

  Planet(
      {required this.image,
      required this.title,
      required this.description,
      required this.size,
      required this.id,
      required this.color});
}

List<Planet> Planets = [
  Planet(
      id: 1,
      title: "planet 1",
      size: 12,
      description: dummyText,
      image: ImageConstant.imgImage,
      color: Color(0xFF3D82AE)),
  Planet(
      id: 2,
      title: "planet 2",
      size: 8,
      description: dummyText,
      image: ImageConstant.imgImage,
      color: Color(0xFFD3A984)),
  Planet(
      id: 3,
      title: "planet 3",
      size: 10,
      description: dummyText,
      image: ImageConstant.imgImage,
      color: Color(0xFF989493)),
  Planet(
      id: 4,
      title: "planet 4",
      size: 11,
      description: dummyText,
      image: ImageConstant.imgImage,
      color: Color(0xFFE6B398)),
  Planet(
      id: 5,
      title: "planet 5",
      size: 12,
      description: dummyText,
      image: ImageConstant.imgImage,
      color: Color(0xFFFB7883)),
  Planet(
    id: 6,
    title: "planet 6",
    size: 12,
    description: dummyText,
    image: ImageConstant.imgImage,
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
