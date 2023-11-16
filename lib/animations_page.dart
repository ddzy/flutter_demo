import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';

double getRandomSize({double min = 0, double max = 80}) {
  return min + (Random().nextDouble() * (max - min));
}

double getRandomMargin() {
  return Random().nextDouble() * 80;
}

Color getRandomColor() {
  return Color(0xffffffff & Random().nextInt(0xffffffff));
}

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
          // LogoAnimation(),
          // LogoAnimation2(),
          // LogoAnimation3(),
          // OpacityAnimation(),
          // SizeAnimation(),
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
    animation = Tween<double>(begin: 0, end: 50).animate(controller)
      ..addStatusListener((status) {
        // 循环动画
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
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
        ElevatedButton(onPressed: () async {}, child: const Text("Reset")),
        _LogoAnimation2Helper(
          animation: animation,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class _LogoAnimation2Helper extends AnimatedWidget {
  const _LogoAnimation2Helper({required Animation<double> animation})
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

class LogoAnimation3 extends StatefulWidget {
  const LogoAnimation3({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogoAnimation3State();
  }
}

class _LogoAnimation3State extends State<LogoAnimation3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _LogoAnimation3Helper(
      animation: animation,
    );
  }
}

class _LogoAnimation3Helper extends AnimatedWidget {
  const _LogoAnimation3Helper({required Animation<double> animation})
      : super(listenable: animation);

  static final opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final sizeTween = Tween<double>(begin: 0, end: 50);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Center(
      child: Opacity(
        opacity: opacityTween.evaluate(animation),
        child: SizedBox(
          child: const FlutterLogo(),
          width: sizeTween.evaluate(animation),
          height: sizeTween.evaluate(animation),
        ),
      ),
    );
  }
}

class OpacityAnimation extends StatefulWidget {
  const OpacityAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpacityAnimationState();
  }
}

class _OpacityAnimationState extends State<OpacityAnimation> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            child: Image.network(
              "https://oss.yyge.top/test/images/7.jpg",
              fit: BoxFit.cover,
            ),
            margin: const EdgeInsets.only(top: 8),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  opacity = 1;
                });
              },
              child: const Text("Show Details"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  opacity = 0;
                });
              },
              child: const Text("Hide Details"),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: const Column(
            children: [
              Text("Type: Ow1"),
              Text("Age: 39"),
              Text("Employment: None"),
            ],
          ),
        ),
      ],
    );
  }
}

class SizeAnimation extends StatefulWidget {
  const SizeAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SizeAnimationState();
  }
}

class _SizeAnimationState extends State<SizeAnimation> {
  late double width;
  late double height;
  late double borderRadius;
  late double margin;
  late Color color;

  void resetValue() {
    var size = getRandomSize(min: 50, max: 100);
    var color = getRandomColor();
    width = size;
    height = size;
    borderRadius = getRandomSize();
    margin = getRandomMargin();
    color = color;
  }

  @override
  void initState() {
    super.initState();
    resetValue();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: width,
              height: height,
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color,
              ),
            ),
          ),
          width: 100,
          height: 100,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                resetValue();
              });
            },
            child: const Text("Change"))
      ],
    );
  }
}
