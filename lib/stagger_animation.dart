import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class StaggerAnimation extends StatefulWidget {
  const StaggerAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StaggerAnimationState();
  }
}

class _StaggerAnimationState extends State<StaggerAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stagger(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.forward();
                },
                child: const Text("Play"))
          ],
        ),
      ),
    );
  }
}

class Stagger extends StatelessWidget {
  Stagger({super.key, required this.controller})
      : opacityAnimation = Tween<double>(begin: 0.5, end: 1).animate(
            CurvedAnimation(parent: controller, curve: const Interval(0, 0.1))),
        widthAnimation = Tween<double>(begin: 50, end: 150).animate(
            CurvedAnimation(
                parent: controller, curve: const Interval(0.125, 0.250))),
        heightAnimation = Tween<double>(begin: 50, end: 150).animate(
            CurvedAnimation(
                parent: controller, curve: const Interval(0.250, 0.375))),
        borderRadiusAnimation = Tween<BorderRadius>(
                begin: BorderRadius.zero,
                end: const BorderRadius.all(Radius.circular(8)))
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.250, 0.375))),
        paddingAnimation = Tween<EdgeInsets>(
                begin: const EdgeInsets.all(20), end: const EdgeInsets.all(40))
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.375, 0.500))),
        colorAnimation = Tween<Color>(begin: Colors.blue, end: Colors.green)
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.500, 0.750)));

  final Animation<double> controller;
  final Animation<double> opacityAnimation;
  final Animation<double> widthAnimation;
  final Animation<double> heightAnimation;
  final Animation<EdgeInsets> paddingAnimation;
  final Animation<BorderRadius> borderRadiusAnimation;
  final Animation<Color> colorAnimation;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: Container(
        width: widthAnimation.value,
        height: heightAnimation.value,
        padding: paddingAnimation.value,
        decoration: BoxDecoration(
          borderRadius: borderRadiusAnimation.value,
          color: colorAnimation.value,
        ),
      ),
    );
  }
}
