import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class RouteAnimationPage extends StatelessWidget {
  const RouteAnimationPage({super.key});

  Widget buildPage(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.yellow,
        child: Center(
          child: InkWell(
            child: const Icon(
              Icons.two_k,
              color: Colors.black,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Animation Page 1"),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: InkWell(
            child: const Icon(
              Icons.one_k,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return buildPage(context);
                },
                transitionDuration: const Duration(milliseconds: 300),
                reverseTransitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  /// 以本例为例对 animation 和 secondaryAnimation 做说明：
                  /// 1、当 push 了 _Page2 时，则 _Page2 做 animation 正向动画
                  /// 2、如果当前显示的是 _Page2，当你 pop 了这个 _Page2 时，则这个 _Page2 会做 animation 反向动画
                  /// 3、如果当前显示的是 _Page2，当你 push 了其他页的时候，则这个 _Page2 会做 secondaryAnimation 正向动画
                  /// 4、如果 _Page2 是路由栈中从栈顶开始数的第 2 个路由，则栈顶 pop 后，这个 _Page2 会做 secondaryAnimation 反向动画
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.ease)).animate(animation),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(0.0, 1.0),
                      )
                          .chain(CurveTween(curve: Curves.ease))
                          .animate(secondaryAnimation),
                      child: child,
                    ),
                  );
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
