import 'package:flutter/material.dart';

class PostsHeroAnimation extends StatefulWidget {
  const PostsHeroAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PostsHeroAnimationState();
  }
}

class _PostsHeroAnimationState extends State<PostsHeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Hero Animation'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
