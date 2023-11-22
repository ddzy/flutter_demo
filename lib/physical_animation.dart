import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicalAnimation extends StatelessWidget {
  const PhysicalAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DraggableCard(
          child: FlutterLogo(
        size: 100,
      )),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _DraggableCardState();
  }
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Alignment> tween;

  Alignment alignment = const FractionalOffset(0.5, 0.5);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {
          alignment = tween.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Align(
        alignment: alignment,
        child: Card(
          child: widget.child,
        ),
      ),
      onPanDown: (details) {
        controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          alignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        var pixelsPerSecond = details.velocity.pixelsPerSecond;
        // 将像素速度转为 controller 所使用的逻辑像素速度[0, 1]
        var unitsPerSecondX = pixelsPerSecond.dx / size.width;
        var unitsPerSecondY = pixelsPerSecond.dy / size.height;
        var unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
        var unitVelocity = unitsPerSecond.distance;
        const spring = SpringDescription(
          mass: 30,
          stiffness: 1,
          damping: 1,
        );
        var simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

        tween = AlignmentTween(begin: alignment, end: Alignment.center)
            .animate(controller);
        controller.animateWith(simulation);
      },
    );
  }
}
