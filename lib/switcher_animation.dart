import 'package:flutter/material.dart';

class SwitcherAnimation extends StatefulWidget {
  const SwitcherAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SwitcherAnimationState();
  }
}

class _SwitcherAnimationState extends State<SwitcherAnimation> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          child: Text(
            "$num",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            // Key 是必须的，不设置 key 的话，动画效果无法生效
            key: ValueKey(num),
          ),
          transitionBuilder: (child, animation) {
            var tween = Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.linear));
            var newAnimation = tween.animate(animation);

            return SlideTransition(
              position: newAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            num += 1;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
