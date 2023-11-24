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
  bool visibleMenu = false;
  late AnimationController controller;
  late AlignmentTween alignmentTween;

  void toggleMenu() {
    setState(() {
      visibleMenu = !visibleMenu;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    alignmentTween = AlignmentTween();
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
              icon: Icon(!visibleMenu ? Icons.menu : Icons.close)),
        ],
      ),
      body: AnimatedAlign(
        alignment: visibleMenu ? Alignment(0, 0) : Alignment(3, 0),
        duration: const Duration(milliseconds: 300),
        child: MenuStagger(),
        curve: Curves.ease,
      ),
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

class _MenuStaggerState extends State<MenuStagger> {
  List<String> textList = [
    "Declarative style",
    "Premade widgets",
    "Stateful hot reload",
    "Native performance",
    "Great community",
  ];

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
    return Column(
      children: [
        ...textList
            .asMap()
            .map((i, e) => MapEntry(
                i,
                Container(
                  child: ListTile(
                    title: Text(e),
                    contentPadding: const EdgeInsets.fromLTRB(36, 12, 0, 12),
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24),
                  ),
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
