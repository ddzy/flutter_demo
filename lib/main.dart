import 'dart:async';

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
      body: const Column(children: [GestureButton(), BottomMenu(), Swiper()]),
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

class Swiper extends StatefulWidget {
  const Swiper({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SwiperState();
  }
}

class _SwiperState extends State<Swiper> {
  final List<CommonIdAndName> imgList = [
    CommonIdAndName(id: 'https://oss.yyge.top/test/images/7.jpg', name: ''),
    CommonIdAndName(id: 'https://oss.yyge.top/test/images/8.jpg', name: ''),
    CommonIdAndName(id: 'https://oss.yyge.top/test/images/9.jpg', name: ''),
  ];

  int currentActiveIndex = 0;
  final PageController pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // 自动轮播
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var nextActiveIndex = (currentActiveIndex + 1) % imgList.length;
      pageController.animateToPage(nextActiveIndex,
          curve: Curves.ease, duration: const Duration(milliseconds: 400));
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  List<Widget> genImgList() {
    return imgList
        .map((v) => (Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.network(v.id).image, fit: BoxFit.cover)),
            )))
        .toList();
  }

  List<Widget> genDotList() {
    return imgList
        .asMap()
        .entries
        .map((e) => GestureDetector(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10000),
                  color:
                      e.key == currentActiveIndex ? Colors.blue : Colors.white,
                ),
                margin: const EdgeInsets.only(left: 8),
              ),
              onTap: () {
                pageController.animateToPage(e.key,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 400));
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(border: Border.all()),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            // 图片
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentActiveIndex = index % imgList.length;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              Image.network(imgList[index % imgList.length].id)
                                  .image,
                          fit: BoxFit.cover)),
                );
              },
            ),
            // 左箭头
            Positioned(
              child: GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () {
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                },
              ),
              left: 16,
            ),
            // 右箭头
            Positioned(
              child: GestureDetector(
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease);
                  }),
              right: 16,
            ),
            // 圆点
            Positioned(
                bottom: 16,
                child: Row(
                  children: genDotList(),
                ))
          ],
        ),
        margin: const EdgeInsets.all(8),
      ),
      onHorizontalDragDown: (details) {
        // 手指拖拽时停止自动轮播
        timer?.cancel();
      },
    );
  }
}
