import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

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
    // 从 shared_prefrences 恢复数据
    // restore();
    // 从文件恢复数据
    restoreFromFile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> get _localPath async {
    var directory;
    try {
      directory = await getApplicationDocumentsDirectory();
      inspect(directory);
    } catch (e) {}
    return directory?.path ?? '';
  }

  Future<File> get _localFile async {
    try {
      final path = await _localPath;
      return File("$path/counter.txt");
    } catch (e) {
      return File('');
    } finally {}
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

  void saveToFile() async {
    try {
      final file = await _localFile;
      await file.writeAsString('$counter');
    } catch (e) {
      inspect(e);
    }
  }

  void restoreFromFile() async {
    try {
      final file = await _localFile;
      var content = await file.readAsString();
      setState(() {
        counter = int.parse(content);
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
            // 缓存写入 shared_preferences
            save();
            // 缓存写入文件
            saveToFile();
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
