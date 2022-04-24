import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';

class PlayButton extends StatelessWidget {
  List podcast;
  int index;
  PlayButton(this.podcast, this.index);
  final PodCastController audioController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (audioController.audioState.value == PlayerState.PLAYING) {
            audioController.audioPause();
          } else {
            audioController.audioPlay(podcast[index]['attributes']['file']
                    ['data']['attributes']['url']
                .toString());
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          // height: MediaQuery.of(context).size.height * 0.4,
          // width: MediaQuery.of(context).size.width * 0.4,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: GetX<PodCastController>(
            builder: (snap) {
              if (snap.audioState.value == PlayerState.PLAYING) {
                return Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 30,
                );
              } else {
                return Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 30,
                );
              }
            },
          ),
        ));
  }
  
}
