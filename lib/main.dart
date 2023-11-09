import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        '文本方向：从左到右',
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.yellow, fontSize: 20),
      )
    )
  );
}
