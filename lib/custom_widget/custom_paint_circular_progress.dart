import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomPaintCircularProgress extends StatefulWidget {
  CustomPaintCircularProgress({
    super.key,
    required this.percent,
    this.trackWidth = 10,
    this.radius = 50,
    this.progressColor = Colors.blue,
    this.gradientColorList = const [
      Colors.orange,
      Colors.yellow,
    ],
    this.gradientStopList = const [0, 1],
    this.isGradient = false,
  }) : trackColor = Colors.grey.shade200;

  /// 进度（百分比）
  final double percent;

  /// 轨道宽度
  final double trackWidth;

  /// 轨道颜色
  final Color trackColor;

  /// 圆环半径
  final double radius;

  /// 进度条颜色
  final Color progressColor;

  /// 进度条渐变颜色列表
  final List<Color> gradientColorList;

  final List<double> gradientStopList;

  /// 是否启用渐变色进度条
  final bool isGradient;

  @override
  State<StatefulWidget> createState() {
    return _CustomPaintCircularProgressState();
  }
}

class _CustomPaintCircularProgressState
    extends State<CustomPaintCircularProgress> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 600,
        ));
    _animation = Tween<double>(begin: 0, end: widget.percent / 100)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var diameter = widget.radius * 2 + widget.trackWidth;

    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.reset();
          _controller.forward();
        });
      },
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: CircularProgressPainter(
                  factor: _animation.value,
                  radius: widget.radius,
                  trackWidth: widget.trackWidth,
                  trackColor: widget.trackColor,
                  progressColor: widget.progressColor,
                  colors: widget.gradientColorList,
                  stops: widget.gradientStopList,
                  isGradient: widget.isGradient,
                ),
                size: Size(diameter, diameter),
              );
            }),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter({
    required this.factor,
    required this.radius,
    required this.trackWidth,
    required this.trackColor,
    required this.progressColor,
    required this.colors,
    required this.stops,
    required this.isGradient,
  });

  double factor;
  final double radius;
  final double trackWidth;
  final Color trackColor;
  final Color progressColor;
  final List<Color> colors;
  final List<double> stops;
  final bool isGradient;

  double _radian2Angle(double radian) {
    return 180 / math.pi * radian;
  }

  double _angle2Radian(double angle) {
    return math.pi / 180 * angle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 整个进度条组件的实际半径
    var actualRadius = trackWidth / 2 + radius;
    // 防止溢出
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    if (!this.isGradient) {
      var trackRect = Rect.fromCircle(
          center: Offset(actualRadius, actualRadius), radius: radius);
      // 纯色进度条
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
            ..color = progressColor);
    } else {
      // 渐变进度条
      var trackRect = Rect.fromCircle(
          center: Offset(actualRadius, actualRadius), radius: radius);

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
                    colors: colors,
                    stops: stops.map((e) => e * factor).toList())
                .createShader(trackRect));
    }
  }
}
