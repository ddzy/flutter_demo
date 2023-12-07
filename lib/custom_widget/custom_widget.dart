import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'custom_button.dart' show CustomButton;

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomWidgetState();
  }
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义widget"),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              child: const Text("Custom Button"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
