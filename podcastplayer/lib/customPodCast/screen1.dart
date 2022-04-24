import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/customPodCast/demo.dart';
import 'package:podcastplayer/customPodCast/theAllPoadCast.dart';
import 'package:podcastplayer/playerWithModel/allPodCastModel.dart';
import 'package:podcastplayer/podCastPlayer/allPodCast.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The PodCast Player'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            child: Text('PodCast'),
            onPressed: () {
              // Get.to(TheAllPodCast());
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> Demo()))
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TheAllPodCast()));
            }),
      ),
    );
  }
}
