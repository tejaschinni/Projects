import 'dart:convert';

import 'package:assignment1/data/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonDemo extends StatefulWidget {
  const JsonDemo({Key? key}) : super(key: key);

  @override
  _JsonDemoState createState() => _JsonDemoState();
}

class _JsonDemoState extends State<JsonDemo> {
  List<Food>? food;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: food!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(food![index].name),
              );
            }),
      ),
    );
  }

  Future<void> getList() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/tejaschinni/caloriecounter/main/food.json'));

    setState(() {
      food = (json.decode(response.body) as List)
          .map((data) => Food.fromJson(data))
          .toList();
    });
  }
}
