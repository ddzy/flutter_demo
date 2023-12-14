import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageWidget extends StatefulWidget {
  const StorageWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StorageWidgetState();
  }
}

class _StorageWidgetState extends State<StorageWidget> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    restore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void save() async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setInt('__counter__', counter);
    } catch (error) {}
  }

  void restore() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final newCounter = storage.getInt('__counter__');
      setState(() {
        counter = newCounter ?? 0;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("数据持久化"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter += 1;
            save();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          '$counter',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
