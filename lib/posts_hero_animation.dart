import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/animations_page.dart';
import 'package:http/http.dart' as http;

class Posts {
  const Posts(
      {required this.id,
      required this.title,
      required this.body,
      required this.color});

  final int id;
  final String title;
  final String body;
  final Color color;

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        color: json['color']);
  }
}

List<Posts> parsePosts(String body) {
  var list = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
  return list.map<Posts>((e) {
    e.addAll({'color': getRandomColor()});
    return Posts.fromJson(e);
  }).toList();
}

class PostsHeroAnimation extends StatefulWidget {
  const PostsHeroAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PostsHeroAnimationState();
  }
}

class _PostsHeroAnimationState extends State<PostsHeroAnimation> {
  Future<List<Posts>> _fetchList() async {
    var res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    return compute(parsePosts, res.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Hero Animation'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: FutureBuilder<List<Posts>>(
          future: _fetchList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (snapshot.hasData) {
              return ListView(
                children: [
                  ...snapshot.data!
                      .map<Widget>((e) => ListTile(
                            title: Text(e.title),
                            subtitle: Text(e.body),
                            leading: CircleAvatar(
                              backgroundColor: e.color,
                            ),
                            onTap: () {},
                          ))
                      .toList(),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
