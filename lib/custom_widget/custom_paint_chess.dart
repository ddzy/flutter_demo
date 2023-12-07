import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class CustomPaintChess extends StatelessWidget {
  const CustomPaintChess({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: ChessPainter(),
      child: RepaintBoundary(
        child: Container(),
      ),
    );
  }
}

class ChessPainter extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 溢出画布之外的隐藏
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);
    canvas.drawCircle(Offset.zero, 50, Paint());
  }
}
