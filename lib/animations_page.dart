import 'dart:developer';

import 'package:flutter/material.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimationsPageState();
  }
}

class _AnimationsPageState extends State<AnimationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: const Column(
        children: [
          LogoAnimation(),
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
