import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/animations_page.dart';
import 'package:http/http.dart' as http;

class Posts {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Posts(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body']);
  }
}

class HttpWidget extends StatefulWidget {
  const HttpWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HttpWidgetState();
  }
}

class _HttpWidgetState extends State<HttpWidget> {
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  void _fetchList() async {
    try {
      var res = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        setState(() {
          postsList = List<Posts>.from(data.map((v) {
            return Posts.fromJson(v);
          }));
        });
      }
    } catch (error) {
      inspect(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _fetchList();
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemBuilder: (context, index) {
            final item = postsList[index];

            return Container(
              margin: const EdgeInsets.only(top: 12),
              child: Material(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.body),
                  leading: CircleAvatar(
                    backgroundColor: getRandomColor(),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onTap: () {},
                ),
              ),
            );
          },
          itemCount: postsList.length,
        ),
      ),
    );
  }
}
