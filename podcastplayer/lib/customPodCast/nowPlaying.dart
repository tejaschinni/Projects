import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';
import 'package:podcastplayer/customPodCast/mySlider.dart';
import 'package:podcastplayer/widget/playButton.dart';

class NowPlaying extends StatelessWidget {
  List podcast;
  int index;
  NowPlaying(this.podcast, this.index);

  final PodCastController audioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child:
                  Text(podcast[index]['attributes']['SeriesName'].toString()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(podcast[index]['attributes']['Name'].toString()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Image.network(podcast[index]['attributes']['Banner']
                      ['data']['attributes']['formats']['thumbnail']['url']
                  .toString()),
            ),
            SizedBox(
              height: 20,
            ),
            MySlider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Obx(
                () {
                  String positionMin = audioController.position.value
                      .toString()
                      .split('.')
                      .first
                      .split(':')[1];
                  String positionSec = audioController.position.value
                      .toString()
                      .split('.')
                      .first
                      .split(':')
                      .last;
                  String totalMin = audioController.totalDuration.value
                      .toString()
                      .split('.')
                      .first
                      .split(':')[1];
                  String totalSec = audioController.totalDuration.value
                      .toString()
                      .split('.')
                      .first
                      .split(':')
                      .last;
                  return Row(
                    children: [
                      Text(
                        '$positionMin:$positionSec',
                        // style: TextStyle(color: AppColors.lightGrey),
                      ),
                      Spacer(),
                      Text(
                        '$totalMin:$totalSec',
                        // style: TextStyle(color: AppColors.lightGrey),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PlayButton(podcast, index),
            // Container(
            //   child: IconButton(
            //       padding: EdgeInsets.only(bottom: 10),
            //       onPressed: () {
            //         if (_isPlaying == false) {
            //           controller.audioPlay(widget.podCast['attributes']
            //                   ['file']['data']['attributes']['url']
            //               .toString());
            //           setState(() {
            //             _isPlaying = true;
            //           });
            //         } else if (_isPlaying == true) {
            //           controller.audioPause();
            //           setState(() {
            //             _isPlaying = false;
            //           });
            //         }
            //       },
            //       icon: _isPlaying == false
            //           ? Icon(
            //               _icons[0],
            //               size: 50,
            //               color: Colors.orange,
            //             )
            //           : Icon(_icons[1], size: 50, color: Colors.orange)),
            // )
          ],
        ),
      ),
    );
  }
}
