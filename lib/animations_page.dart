import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: const Column(
        children: [
          LogoAnimation(),
          LogoAnimation2(),
        ],
      ),
    );
  }
}

// logo 放大动画
class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LogoAnimationState();
  }
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 50).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              animationController.reset();
              animationController.forward();
            },
            child: const Text("Play")),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        )
      ],
    );
  }
}

class LogoAnimation2 extends StatefulWidget {
  const LogoAnimation2({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LogoAnimation2State();
  }
}

class _LogoAnimation2State extends State<LogoAnimation2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 50).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () async {
              controller.reverse();
              await Future.delayed(const Duration(seconds: 2));
              controller.reset();
              controller.forward();
            },
            child: const Text("Play")),
        _LogoAnimation2Helper(
          animation: animation,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class _LogoAnimation2Helper extends AnimatedWidget {
  const _LogoAnimation2Helper({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return SizedBox(
      child: const FlutterLogo(),
      width: animation.value,
      height: animation.value,
    );
  }
}
