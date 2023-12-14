import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final int id;
  final String title;
  final String url;

  const Album({
    required this.id,
    required this.title,
    required this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json['id'], title: json['title'], url: json['url']);
  }
}

List<Album> parseAlbums(String res) {
  // 直接使用 as 会报错，需要调用 cast 方法
  // var parsed = (jsonDecode(res) as List<Map<String, dynamic>>)
  var parsed = (jsonDecode(res) as List).cast<Map<String, dynamic>>();
  return parsed
      .map<Album>(
        (e) => Album.fromJson(e),
      )
      .toList();
}

class BackstageJson extends StatefulWidget {
  const BackstageJson({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BackstageJsonState();
  }
}

class _BackstageJsonState extends State<BackstageJson> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Album>> fetchAlbums() async {
    var res = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos"));

    return compute(parseAlbums, res.body);
  }

  Widget _buildAlbums(List<Album> list) {
    return GridView.builder(
        itemCount: list.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Image.network(list[index].url);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("后台解析JSON"),
      ),
      body: FutureBuilder<List<Album>>(
          future: fetchAlbums(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return _buildAlbums(snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
