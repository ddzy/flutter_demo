import 'package:flutter/material.dart';

class MenuStaggerAnimation extends StatefulWidget {
  const MenuStaggerAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuStaggerAnimationState();
  }
}

class _MenuStaggerAnimationState extends State<MenuStaggerAnimation>
    with TickerProviderStateMixin {
  /// 菜单是否显示
  /// 利用 [ValueNotifier] 监听值的变化（菜单是否展开），来控制动画
  /// * late 关键字可以延迟赋值，为了不用在 initState 中赋值
  late ValueNotifier<bool> visibleMenu = ValueNotifier(false);
  late AnimationController controller;
  late Animation<Offset> animation;

  void toggleMenu() {
    visibleMenu.value = !visibleMenu.value;
    if (isMenuClosed()) {
      controller.forward();
    } else if (isMenuOpened()) {
      controller.reverse();
    }

    setState(() {});
  }

  bool isMenuOpened() {
    return controller.status == AnimationStatus.completed;
  }

  bool isMenuClosed() {
    return controller.status == AnimationStatus.dismissed;
  }

  bool isMenuMoving() {
    return [AnimationStatus.forward, AnimationStatus.reverse]
        .contains(controller.status);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                toggleMenu();
              },
              icon: Icon(!visibleMenu.value ? Icons.menu : Icons.close)),
        ],
      ),
      // ? 方式一
      // body: SlideTransition(
      //   position: animation,
      //   child: isMenuClosed() ? const SizedBox() : const MenuStagger(),
      // ),
      /// ? 方式二: [AnimatedBuilder]
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return SlideTransition(
              position: animation,
              child: isMenuClosed() ? const SizedBox() : const MenuStagger(),
            );
          }),
    );
  }
}

// 菜单
class MenuStagger extends StatefulWidget {
  const MenuStagger({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuStaggerState();
  }
}

class _MenuStaggerState extends State<MenuStagger>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  /// logo
  Widget buildLogo(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Opacity(
          opacity: 0.2,
          child: FlutterLogo(
            size: MediaQuery.of(context).size.width,
          )),
    );
  }

  /// menu-item
  Widget buildContent(BuildContext context) {
    List<String> textList = [
      "Declarative style",
      "Premade widgets",
      "Stateful hot reload",
      "Native performance",
      "Great community",
    ];

    return Column(
      children: [
        ...textList
            .asMap()
            .map((i, e) => MapEntry(
                i,
                ListTile(
                  title: Text(e),
                  contentPadding: const EdgeInsets.fromLTRB(36, 12, 0, 12),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                )))
            .values
            .toList(),
        Expanded(
            child: Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text("Get started"),
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
                  minimumSize:
                      const MaterialStatePropertyAll(Size.fromHeight(50)),
                  textStyle: const MaterialStatePropertyAll(
                    TextStyle(fontSize: 20),
                  ),
                )),
          ),
          alignment: const Alignment(0, 0.6),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          buildLogo(context),
          buildContent(context),
        ],
      ),
    );
  }
}
