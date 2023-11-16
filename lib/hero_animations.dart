import 'package:flutter/material.dart';

class HeroAnimationsPage extends StatelessWidget {
  const HeroAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Hero Animation"),
      ),
      body: Center(
        child: PhotoHero(
          url: 'https://oss.yyge.top/test/images/7.jpg',
          width: 300,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              // Hero目的地
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Hero Destination Page"),
                ),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    url: "https://oss.yyge.top/test/images/7.jpg",
                    width: 100,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

// Hero目标组件
class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {super.key, required this.url, this.onTap, required this.width});

  final String url;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: url,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
