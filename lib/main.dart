import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(const MaterialApp(
    title: 'test',
    home: HomePage(),
  ));
}

class CommonIdAndName {
  final dynamic id;
  final dynamic name;

  CommonIdAndName({
    required this.id,
    required this.name,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  int _count = 0;

  void _increment() {
    setState(() {
      _count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: ((context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  tooltip: 'Menu',
                ))),
        title: const Text('Debug'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: 'Search',
          )
        ],
      ),
      body: const Column(children: [GestureButton(), BottomMenu()]),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            )
          ],
        ),
      ),
    );
  }
}

/// 手势监听 GestureDetector
class GestureButton extends StatelessWidget {
  const GestureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('GestureButton was tapped');
      },
      onDoubleTap: (() {
        log("GestureButton double tapped");
      }),
      onLongPress: () {
        log("GestureButton long tapped");
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[500],
        ),
        child: const Center(child: Text('Engage')),
      ),
    );
  }
}

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});
  @override
  State<StatefulWidget> createState() {
    return _BottomMenuState();
  }
}

class _BottomMenuState extends State<BottomMenu> {
  static final List<CommonIdAndName> menuList = [
    CommonIdAndName(id: Icons.call, name: "CALL"),
    CommonIdAndName(id: Icons.route, name: "ROUTE"),
    CommonIdAndName(id: Icons.share, name: "SHARE"),
  ];

  IconData currentActiveMenu = menuList[0].id;

  toggleMenu(CommonIdAndName v) {
    setState(() {
      currentActiveMenu = v.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), color: Colors.grey[100]),
      child: Row(
        children: menuList.map((v) {
          return Expanded(
              child: GestureDetector(
            child: Column(
              children: [
                Icon(
                  v.id,
                  color: v.id == currentActiveMenu ? Colors.blue : null,
                ),
                Text(
                  v.name,
                  style: TextStyle(
                      color: v.id == currentActiveMenu ? Colors.blue : null),
                )
              ],
            ),
            onTap: () {
              toggleMenu(v);
            },
          ));
        }).toList(),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
