import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/animations_page.dart';
import 'package:http/http.dart' as http;

class Posts {
  const Posts(
      {required this.id,
      required this.title,
      required this.body,
      required this.url,
      required this.image});

  final int id;
  final String title;
  final String body;
  final String url;
  final ImageProvider image;

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        url: json['url'],
        image: json['image']);
  }
}

List<Posts> parsePosts(String body) {
  var list = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
  return list.map<Posts>((e) {
    ImageProvider image = const NetworkImage(
      "https://picsum.photos/300/300",
    );
    e.addAll({'url': 'https://picsum.photos/300/300', 'image': image});
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

  _buildPage(BuildContext context, Posts row) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Image(
                      image: row.image,
                      fit: BoxFit.cover,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      row.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      row.body,
                      textAlign: TextAlign.left,
                      style: const TextStyle(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.share))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
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
                            leading: Hero(
                                tag: e.id,
                                child: CircleAvatar(
                                  backgroundImage: e.image,
                                )),
                            onTap: () {
                              _buildPage(context, e);
                            },
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
