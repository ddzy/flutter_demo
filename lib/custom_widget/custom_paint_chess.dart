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
  /// 每个格子的大小
  final Size gridSize = const Size.square(20);

  /// 多少行
  final int row = 20;

  /// 多少列
  final int column = 20;

  /// 线条宽度
  final double lineWidth = 1;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawRowLine(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < row; i++) {
      canvas.drawLine(Offset(0, i * gridSize.height),
          Offset(size.width, i * gridSize.height), paint);
    }
  }

  void _drawColumnLine(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < column; i++) {
      canvas.drawLine(Offset(i * gridSize.width, 0),
          Offset(i * gridSize.width, size.width), paint);
    }
  }

  void _drawChess(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(gridSize.width * (row / 2), gridSize.height * (column / 2)),
        gridSize.width / 2,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.black);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 溢出画布之外的隐藏
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = lineWidth;
    // 画行
    _drawRowLine(canvas, size, linePaint);
    // 画列
    _drawColumnLine(canvas, size, linePaint);
    // 画棋子
    _drawChess(canvas, size);
  }
}
