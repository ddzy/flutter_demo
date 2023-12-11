import 'dart:developer';
import 'package:flutter/material.dart';

class CustomCheckbox extends LeafRenderObjectWidget {
  const CustomCheckbox({super.key, this.radius = 10, this.strokeWidth = 4});

  /// 复选框半径
  final double radius;

  /// 勾号宽度
  final double strokeWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(radius: radius, strokeWidth: strokeWidth);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomCheckbox renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.radius = radius;
    renderObject.strokeWidth = strokeWidth;
  }
}

class RenderCustomCheckbox extends RenderBox {
  RenderCustomCheckbox({required this.radius, required this.strokeWidth});

  double radius;
  double strokeWidth;

  @override
  void performLayout() {
    size = constraints.constrain(
        constraints.isTight ? Size.infinite : Size(radius * 2, radius * 2));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var canvas = context.canvas;
    var rrect = RRect.fromRectAndRadius(
        Rect.fromCircle(
            center: Offset(offset.dx + radius, offset.dy + radius),
            radius: radius),
        const Radius.circular(6));

    // 画背景
    canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black);
    // 画蓝色背景
    canvas.drawRRect(rrect, Paint()..color = Colors.blue);
    // 画勾号
    var p1 = Offset(offset.dx + radius / 3, offset.dy + radius);
    var p2 = Offset(offset.dx + radius, p1.dy + radius / 3);
    var p3 = Offset(p2.dx + radius / 2, offset.dy + radius / 3);
    canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = Colors.white
          ..strokeWidth = strokeWidth);
    canvas.drawLine(
        p2,
        p3,
        Paint()
          ..color = Colors.white
          ..strokeWidth = strokeWidth);
  }
}
