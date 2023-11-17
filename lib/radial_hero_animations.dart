import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class RadialHeroAnimationsPage extends StatelessWidget {
  const RadialHeroAnimationsPage({super.key});

  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);
  static RectTween createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget buildPage(
      BuildContext context, String url, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: createRectTween,
                  tag: url,
                  child: RadialExpansion(
                      maxRadius: kMaxRadius,
                      child: RadialPhoto(
                        url: url,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHero(
    BuildContext context,
    String url,
    String description,
  ) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        tag: url,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: RadialPhoto(
            url: url,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: buildPage(context, url, description),
                      );
                    });
              }));
            },
          ),
        ),
        createRectTween: createRectTween,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Radial Transition"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildHero(
                context, "https://oss.yyge.top/test/images/7.jpg", 'Chair'),
            buildHero(context, "https://oss.yyge.top/test/images/8.jpg",
                'Binoculars'),
            buildHero(context, "https://oss.yyge.top/test/images/9.jpg",
                'Beach ball'),
          ],
        ),
      ),
    );
  }
}

class RadialPhoto extends StatelessWidget {
  const RadialPhoto({super.key, required this.url, this.onTap});

  final String url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (context, constraints) {
          return Image.network(
            url,
            fit: BoxFit.contain,
          );
        }),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion(
      {super.key, required this.maxRadius, required this.child})
      : clipRectSize = 2 * (maxRadius / sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
