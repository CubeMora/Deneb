
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
 final String svgPath;
 final Color color;

 SvgIcon({required this.svgPath, required this.color});

 @override
 Widget build(BuildContext context) {
   return SvgPicture.asset(
     svgPath,
     width: 24,
     height: 24,
     color: color,
   );
 }
}
