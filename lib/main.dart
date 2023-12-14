import 'dart:async';
import 'package:flutter/material.dart';
import 'page_turn_animation.dart' show PageTurnAnimation;
import 'dart:developer';
import 'package:provider/provider.dart';
import 'animations_page.dart';
import 'basic_hero_animations.dart';
import 'radial_hero_animations.dart';
import 'route_animation.dart';
import 'physical_animation.dart' show PhysicalAnimation;
import 'stagger_animation.dart' show StaggerAnimation;
import 'menu_stagger_animation.dart' show MenuStaggerAnimation;
import 'switcher_animation.dart' show SwitcherAnimation;
import 'custom_widget/custom_widget.dart' show CustomWidget;
import 'shopping/shopping.dart' show Shopping;
import 'shopping/shopping_cart.dart' show ShoppingCart;
import 'shopping/shopping_model.dart' show ShoppingProvider;
import 'http_widget/http_widget.dart' show HttpWidget;
import 'http_widget/backstage_json.dart' show BackstageJson;

class Router {
  Router(this.context);

  BuildContext context;

  Route<dynamic> generateRoute(RouteSettings settings) {
    // ? 路由校验
    switch (settings.name) {
      case "/profile":
        return MaterialPageRoute(builder: (context) {
          return const ProfilePage();
        });
      case "/settings":
        return MaterialPageRoute(builder: (context) {
          return const DefaultTabController(length: 3, child: SettingsPage());
        });
      case "/animations":
        return MaterialPageRoute(builder: (context) {
          return const AnimationsPage();
        });
      case "/basic-hero-animation":
        return MaterialPageRoute(builder: (context) {
          return const BasicHeroAnimationsPage();
        });
      case "/radial-hero-animation":
        return MaterialPageRoute(builder: (context) {
          return const RadialHeroAnimationsPage();
        });
      case "/route-animation":
        return MaterialPageRoute(builder: (context) {
          return const RouteAnimationPage();
        });
      case "/page_turn":
        return MaterialPageRoute(builder: (context) {
          return const PageTurnAnimation();
        });
      case "/physical-animation":
        return MaterialPageRoute(builder: (context) {
          return const PhysicalAnimation();
        });
      case "/stagger-animation":
        return MaterialPageRoute(builder: (context) {
          return const StaggerAnimation();
        });
      case "/menu-stagger-animation":
        return MaterialPageRoute(builder: (context) {
          return const MenuStaggerAnimation();
        });
      case "/switcher-animation":
        return MaterialPageRoute(builder: (context) {
          return const SwitcherAnimation();
        });
      case "/custom-widget":
        return MaterialPageRoute(builder: (context) {
          return const CustomWidget();
        });
      case "/shopping":
        return MaterialPageRoute(builder: (context) {
          // return const Shopping();
          return const Shopping();
        });
      case "/shopping-cart":
        return MaterialPageRoute(builder: (context) {
          return const ShoppingCart();
        });
      case "/http":
        return MaterialPageRoute(builder: (context) {
          return const HttpWidget();
        });
      case "/backstage-json":
        return MaterialPageRoute(builder: (context) {
          return const BackstageJson();
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("404"),
            ),
          );
        });
    }
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'test',
          home: const HomePage(),
          routes: {
            '/message': (context) => const MessagePage(
                  message: "123",
                ),
            // '/profile': (context) => const ProfilePage(),
            // '/settings': (context) => const SettingsPage(),
          },
          onGenerateRoute: Router(context).generateRoute,
        );
      },
    ),
  );
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

  void _increment() {
    setState(() {});
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
      body: ListView(
        children: const [
          Column(children: [
            GestureButton(),
            BottomMenu(),
            Swiper(),
            InfoCard(),
            InkWellUse(),
            ListDismiss(),
          ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('路由传参'),
              onTap: () {
                Navigator.pushNamed(context, "/settings", arguments: {
                  'list': [1, 2, 3],
                  'int': 1,
                  'String': '1',
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.airplanemode_active_outlined),
              title: const Text("基础 Hero 动画"),
              onTap: () {
                Navigator.pushNamed(context, "/basic-hero-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.airplane_ticket),
              title: const Text("径向 Hero 动画"),
              onTap: () {
                Navigator.pushNamed(context, "/radial-hero-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.change_circle),
              title: const Text("路由切换动画"),
              onTap: () {
                Navigator.pushNamed(context, "/route-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.turn_left),
              title: const Text("页面转场动画"),
              onTap: () {
                Navigator.pushNamed(context, "/page_turn");
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text("模拟物理特性动画"),
              onTap: () {
                Navigator.pushNamed(context, "/physical-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_bar),
              title: const Text("交错动画"),
              onTap: () {
                Navigator.pushNamed(context, "/stagger-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text("菜单交错动画"),
              onTap: () {
                Navigator.pushNamed(context, "/menu-stagger-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.switch_access_shortcut),
              title: const Text("AnimatedSwitcher数字新老交替"),
              onTap: () {
                Navigator.pushNamed(context, "/switcher-animation");
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text("自定义组件"),
              onTap: () {
                Navigator.pushNamed(context, "/custom-widget");
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text("购物"),
              onTap: () {
                Navigator.pushNamed(context, "/shopping");
              },
            ),
            ListTile(
              leading: const Icon(Icons.http),
              title: const Text("HTTP"),
              onTap: () {
                Navigator.pushNamed(context, "/http");
              },
            ),
            ListTile(
              leading: const Icon(Icons.enhance_photo_translate),
              title: const Text("后台解析JSON"),
              onTap: () {
                Navigator.pushNamed(context, "/backstage-json");
              },
            ),
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
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   var nextActiveIndex = (currentActiveIndex + 1) % imgList.length;
    //   pageController.animateToPage(nextActiveIndex,
    //       curve: Curves.ease, duration: const Duration(milliseconds: 400));
    // });
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

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InfoCardState();
  }
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // banner 图
        Container(
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  "https://oss.yyge.top/test/images/7.jpg",
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisSize: MainAxisSize.max,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        // banner 说明
        Container(
          child: Row(
            children: [
              Column(
                children: [
                  const Text(
                    "Oeschinen Lake Campground",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: const Text("Kandersteg, Switzerland",
                        style: TextStyle(color: Colors.grey)),
                    margin: const EdgeInsets.only(top: 8),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber[900],
                  ),
                  const Text("41"),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 0),
        ),
        // 动作按钮
        const Row(
          children: [
            Column(
              children: [
                Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                Text(
                  "CALL",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                Text(
                  "SEND",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                Text(
                  "SHARE",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        // 描述文本
        Container(
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  "Lake Oeschinen lies at the foot of the Bltemlisalp inthe Bernese Alps. Situated 1,578 meters above sealevel, it is one of the larger Alpine Lakes. A gondolaride from Kandersteg, followed by a half-hour walkthrough pastures and pine forest, leads youto thelake, which warms to 20 degrees Celsius in thesummer. Activities enjoyed here include rowing, andriding the summer toboggan run.",
                  softWrap: true,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          padding: const EdgeInsets.all(40),
        )
      ],
    );
  }
}

// 水波按钮
class InkWellUse extends StatelessWidget {
  const InkWellUse({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text("InkWell Button"),
      ),
      onTap: () {
        log("InkWell Button tapped");
      },
    );
  }
}

// 列表滑动清除
class ListDismiss extends StatefulWidget {
  const ListDismiss({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListDismissState();
  }
}

class _ListDismissState extends State<ListDismiss> {
  final items = List.generate(20, (index) => 'Item $index');
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              setState(() {
                // 添加一条新数据
                items.add('Item ${items.length}');
              });
              await Future.delayed(const Duration(milliseconds: 100));
              // 更新 ListView 的滚动位置
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.ease);
            },
            child: const Text("Add Item")),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: Key(item),
                child: ListTile(
                  title: Text(item),
                  leading: const Icon(Icons.check),
                ),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Text(
                    '移除',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$item dismissed")));
                },
              );
            },
            itemCount: items.length,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message Page Title"),
      ),
      body: Center(child: Text("Message Page($message)")),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page Title"),
      ),
      body: const Center(child: Text("Profile Page")),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    inspect(args);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page Title"),
        bottom: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              icon: Icon(Icons.directions_transit),
            ),
            Tab(
              icon: Icon(Icons.directions_bike),
            ),
          ],
        ),
      ),
      body: const TabBarView(children: [
        Center(
          child: Icon(Icons.directions_car),
        ),
        Center(
          child: Icon(Icons.directions_transit),
        ),
        Center(
          child: Icon(Icons.directions_bike),
        )
      ]),
    );
  }
}
