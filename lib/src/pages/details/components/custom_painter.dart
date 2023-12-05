import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{
  final Color gradientColor;

  RPSCustomPainter({super.repaint, required this.gradientColor});
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paint_fill_1.shader = ui.Gradient.linear(Offset(size.width*0.50,size.height*-0.00),Offset(size.width*0.50,size.height*0.39),[gradientColor,Color(0xffffeeee)],[0.00,1.00]); 
         
    Path path_1 = Path();
    path_1.moveTo(size.width*-0.0061000,size.height*0.1660167);
    path_1.quadraticBezierTo(size.width*0.1670333,size.height*0.3592000,size.width*0.3150667,size.height*0.3821083);
    path_1.cubicTo(size.width*0.5083000,size.height*0.3902917,size.width*0.7106333,size.height*0.3119833,size.width*0.8439667,size.height*0.2948250);
    path_1.quadraticBezierTo(size.width*0.8933833,size.height*0.2863500,size.width*1.0089000,size.height*0.2917000);
    path_1.lineTo(size.width*1.0012500,size.height*-0.0030333);
    path_1.lineTo(size.width*-0.0061000,size.height*-0.0018500);

    canvas.drawPath(path_1, paint_fill_1);
  

  // Layer 1
  
  Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    
    canvas.drawPath(path_1, paint_stroke_1);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
