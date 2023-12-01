import 'dart:developer' as dev;
import 'dart:math';

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
  void dispose() {
    super.dispose();
    controller.dispose();
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
  List<String> textList = [
    "Declarative style",
    "Premade widgets",
    "Stateful hot reload",
    "Native performance",
    "Great community",
  ];

  late AnimationController controller;

  /// 动画初始的延迟时间
  late final Duration initialDelayTime;

  /// 列表项运动的持续时间
  late final Duration itemSlideTime;

  /// 列表项运动前的延迟时间
  late final Duration itemDelayTime;

  /// 按钮运动的持续时间
  late final Duration buttonTime;

  /// 按钮运动前的延迟时间
  late final Duration buttonDelayTime;

  /// 动画持续总时长
  late final Duration durationTime;

  @override
  void initState() {
    super.initState();

    initialDelayTime = const Duration(milliseconds: 50);
    itemSlideTime = const Duration(milliseconds: 150);
    itemDelayTime = const Duration(milliseconds: 50);
    buttonTime = const Duration(milliseconds: 300);
    buttonDelayTime = const Duration(milliseconds: 150);
    durationTime = initialDelayTime +
        itemSlideTime +
        itemDelayTime * (textList.length - 1) +
        buttonDelayTime +
        buttonTime;

    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationTime.inMilliseconds))
      ..forward();
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

  List<Widget> buildList() {
    return textList
        .asMap()
        .map((dynamic key, value) {
          // 每一个列表项的动画开始时间（在总的动画时长范围内，即 0 - 1）
          var startTime = (initialDelayTime.inMilliseconds +
              key * itemDelayTime.inMilliseconds);
          // 每一个列表项的动画结束时间（在总的动画时长范围内，即 0 - 1）
          var endTime = (startTime + itemSlideTime.inMilliseconds);
          // 计算每个列表项的动画曲线（即延长时间）
          var tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          );
          var curvedTween = CurveTween(
              curve: Interval(startTime / durationTime.inMilliseconds,
                  endTime / durationTime.inMilliseconds));
          var animation = tween.chain(curvedTween).animate(controller);

          return MapEntry(
              key,
              AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return SlideTransition(
                      position: animation,
                      child: AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: 1 - animation.value.dx,
                              child: ListTile(
                                title: Text(value),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(36, 12, 0, 12),
                                titleTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 24),
                              ),
                            );
                          }),
                    );
                  }));
        })
        .values
        .toList();
  }

  Widget buildButton() {
    return Expanded(
        child: Align(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: ElevatedButton(
            onPressed: () {},
            child: const Text("Get started"),
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
              minimumSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
              textStyle: const MaterialStatePropertyAll(
                TextStyle(fontSize: 20),
              ),
            )),
      ),
      alignment: const Alignment(0, 0.6),
    ));
  }

  /// menu-item
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        ...buildList(),
        buildButton(),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
