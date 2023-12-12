import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, this.radius = 20, this.strokeWidth = 4});

  /// 复选框半径
  final double radius;

  /// 勾号宽度
  final double strokeWidth;

  @override
  State<StatefulWidget> createState() {
    return _CustomCheckboxState();
  }
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomCheckboxCreator(
            key: UniqueKey(),
            radius: widget.radius,
            strokeWidth: widget.strokeWidth,
            animation: _animation,
            onTap: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
          );
        });
  }
}

class CustomCheckboxCreator extends LeafRenderObjectWidget {
  const CustomCheckboxCreator(
      {super.key,
      required this.radius,
      required this.strokeWidth,
      required this.animation,
      required this.onTap});

  final double radius;
  final double strokeWidth;
  final Animation<double> animation;
  final VoidCallback onTap;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomCheckboxRenderer(
        radius: radius,
        strokeWidth: strokeWidth,
        animation: animation,
        onTap: onTap);
  }

  @override
  void updateRenderObject(
      BuildContext context, CustomCheckboxRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.radius = radius;
    renderObject.strokeWidth = strokeWidth;
    renderObject.onTap = onTap;
    renderObject.animation = animation;
  }
}

class CustomCheckboxRenderer extends RenderBox {
  CustomCheckboxRenderer(
      {required this.radius,
      required this.strokeWidth,
      required this.animation,
      required this.onTap});

  double radius;
  double strokeWidth;
  Animation<double> animation;
  VoidCallback onTap;

  _drawYes(Canvas canvas, Offset offset) {
    // 画勾号
    var p1 = Offset(offset.dx + radius / 3, offset.dy + radius);
    var p2 = Offset(offset.dx + radius, p1.dy + radius / 3);
    var p3 = Offset(p2.dx + radius / 2, offset.dy + radius / 3);
    var path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy);
    var metrics = path.computeMetrics();
    var metric = metrics.elementAt(0);
    var extractedPath = metric.extractPath(0, metric.length * animation.value);

    canvas.drawPath(
        extractedPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white
          ..strokeWidth = strokeWidth);
  }

  _drawBackground(Canvas canvas, Offset offset) {
    // 画背景
    var rrect = RRect.fromRectAndRadius(
        Rect.fromCircle(
            center: Offset(offset.dx + radius, offset.dy + radius),
            radius: radius),
        const Radius.circular(6));
    canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.grey);
  }

  _drawBlueBackground(Canvas canvas, Offset offset) {
    // 画蓝色背景
    var rrect = RRect.fromRectAndRadius(
        Rect.fromCircle(
            center: Offset(offset.dx + radius, offset.dy + radius),
            radius: radius),
        const Radius.circular(6));
    var colorLerp =
        Color.lerp(Colors.white, Colors.blue, animation.value) as Color;

    canvas.drawRRect(rrect, Paint()..color = colorLerp);
  }

  @override
  void performLayout() {
    size = constraints.constrain(
        constraints.isTight ? Size.infinite : Size(radius * 2, radius * 2));
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    onTap();
    return super.hitTest(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    _drawBackground(context.canvas, offset);
    _drawBlueBackground(context.canvas, offset);
    _drawYes(context.canvas, offset);
  }
}
