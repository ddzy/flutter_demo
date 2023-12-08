import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPaintCircularProgress extends StatefulWidget {
  const CustomPaintCircularProgress({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomPaintCircularProgressState();
  }
}

class _CustomPaintCircularProgressState
    extends State<CustomPaintCircularProgress> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularProgressPainter(),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  /// 轨道宽度
  double trackWidth = 10;

  /// 进度条半径
  double radius = 50;

  /// 轨道颜色
  Color trackColor = Colors.grey.shade200;

  /// 进度条颜色
  Color progressColor = Colors.blue;

  double _radian2Angle(double radian) {
    return 180 / math.pi * radian;
  }

  double _angle2Radian(double angle) {
    return math.pi / 180 * angle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var diameter = trackWidth + radius;

    // 防止溢出
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);

    // 进度条轨道
    canvas.drawArc(
        Rect.fromCircle(center: Offset(diameter, diameter), radius: radius),
        _angle2Radian(0),
        _angle2Radian(360),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = trackColor);

    // 进度条
    canvas.drawArc(
        Rect.fromCircle(center: Offset(diameter, diameter), radius: radius),
        _angle2Radian(0),
        _angle2Radian(90),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = progressColor);
  }
}
