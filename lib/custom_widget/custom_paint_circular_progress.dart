import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPaintCircularProgress extends StatelessWidget {
  const CustomPaintCircularProgress(
      {super.key,
      required this.percent,
      this.trackWidth,
      this.trackColor,
      this.radius,
      this.progressColor,
      this.gradientColorList,
      this.gradientStopList});

  /// 进度（百分比）
  final double percent;

  /// 轨道宽度
  final double? trackWidth;

  /// 轨道颜色
  final Color? trackColor;

  /// 圆环半径
  final double? radius;

  /// 进度条颜色
  final Color? progressColor;

  /// 进度条渐变颜色列表
  final List<Color>? gradientColorList;

  final List<double>? gradientStopList;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularProgressPainter(
          percent: percent,
          radius: radius ?? 50,
          trackWidth: trackWidth ?? 10,
          trackColor: trackColor ?? Colors.grey.shade200,
          progressColor: progressColor ?? Colors.blue,
          colors: [
            Colors.orange,
            Colors.yellow,
          ],
          stops: [
            0,
            1,
          ]),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter(
      {required this.percent,
      required this.radius,
      required this.trackWidth,
      required this.trackColor,
      required this.progressColor,
      required this.colors,
      required this.stops});

  final double percent;
  final double radius;
  final double trackWidth;
  final Color trackColor;
  final Color progressColor;
  final List<Color> colors;
  final List<double> stops;

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
    var factor = percent / 100;

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
          ..shader = SweepGradient(
                  colors: colors, stops: stops.map((e) => e * factor).toList())
              .createShader(trackRect));
  }
}
