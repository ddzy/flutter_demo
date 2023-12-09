import 'package:flutter/material.dart';

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
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.reset();
          controller.forward();
        },
        child: const Icon(Icons.play_arrow),
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
                end: const BorderRadius.all(Radius.circular(100)))
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.250, 0.375))),
        paddingAnimation = Tween<EdgeInsets>(
                begin: const EdgeInsets.all(20), end: const EdgeInsets.all(40))
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.375, 0.500))),
        colorAnimation = ColorTween(begin: Colors.green, end: Colors.blue)
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0.500, 0.750)));

  final Animation<double> controller;
  final Animation<double> opacityAnimation;
  final Animation<double> widthAnimation;
  final Animation<double> heightAnimation;
  final Animation<EdgeInsets> paddingAnimation;
  final Animation<BorderRadius> borderRadiusAnimation;
  final Animation<Color?> colorAnimation;

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
        child: Center(
          child: Builder(builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width -
                  paddingAnimation.value.left,
              height: MediaQuery.of(context).size.height -
                  paddingAnimation.value.top,
              decoration: const BoxDecoration(color: Colors.white),
            );
          }),
        ),
      ),
    );
  }
}
