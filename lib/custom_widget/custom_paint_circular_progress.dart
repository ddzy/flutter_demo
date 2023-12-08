import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPaintCircularProgress extends StatelessWidget {
  const CustomPaintCircularProgress({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularProgressPainter(factor: percent / 100),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter({required this.factor});

  final double factor;

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

    // 纯色进度条
    canvas.drawArc(
        Rect.fromCircle(center: Offset(diameter, diameter), radius: radius),
        _angle2Radian(0),
        _angle2Radian(360),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = trackColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(diameter, diameter), radius: radius),
        _angle2Radian(0),
        _angle2Radian(90),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = progressColor);

    // 渐变进度条
    var trackRect =
        Rect.fromCircle(center: Offset(diameter * 3, diameter), radius: radius);

    canvas.drawArc(
        trackRect,
        _angle2Radian(0),
        _angle2Radian(360),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = trackColor);
    canvas.drawArc(
        trackRect,
        _angle2Radian(0),
        _angle2Radian(360 * factor),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth
          ..color = progressColor
          ..shader = SweepGradient(colors: const [
            Colors.orange,
            Colors.yellow,
          ], stops: [
            0 * factor,
            1 * factor,
          ]).createShader(trackRect));
  }
}
