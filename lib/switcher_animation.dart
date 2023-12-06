import 'package:flutter/material.dart';
import 'dart:developer' as dev;

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
          child: Text(
            "$num",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            key: ValueKey(num),
          ),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
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
