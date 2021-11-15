import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParseJson extends StatefulWidget {
  const ParseJson({Key? key}) : super(key: key);

  @override
  _ParseJsonState createState() => _ParseJsonState();
}

class _ParseJsonState extends State<ParseJson> {
// do this in dashboard page and then send it to recipies list view
  List<Photo> photos = [];

  Future<void> getList(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    setState(() {
      photos = (json.decode(response.body) as List)
          .map((data) => Photo.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print(photos[4].title);
            },
          ),
          body: photos.length < 0
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(photos[index].title),
                    );
                  })),
    );
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
