import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.child, required this.onTap});

  final Widget? child;

  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() {
    return _CustomButtonState();
  }
}

class _CustomButtonState extends State<CustomButton> {
  double blurRadius = 1;
  Offset blurOffset = const Offset(1, 1);

  @override
  Widget build(BuildContext context) {
    final child = widget.child ?? const SizedBox();

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.cyan,
          Colors.blue,
          Colors.purple,
        ]),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: blurRadius,
            offset: blurOffset,
          )
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          onTapDown: (details) {
            setState(() {
              blurRadius = 2;
              blurOffset = const Offset(2, 2);
            });
          },
          onTapUp: (details) {
            setState(() {
              blurRadius = 1;
              blurOffset = const Offset(1, 1);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: DefaultTextStyle(
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                child: child),
          ),
        ),
      ),
    );
  }
}
