import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'test',
    home: Container(
      child: const SafeArea(child: MyApp(), bottom: false),
      color: Colors.blue[500],
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          MyAppBar(
              title: Text(
            '测试标题',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          Expanded(child: Center(child: Text('测试内容')))
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final Widget title;

  const MyAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.menu),
            tooltip: '菜单',
          ),
          Expanded(child: title),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: '搜索',
          ),
        ],
      ),
    );
  }
}
