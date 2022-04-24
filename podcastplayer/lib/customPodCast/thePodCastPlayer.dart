import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';
import 'package:podcastplayer/customPodCast/mySlider.dart';
import 'package:podcastplayer/customPodCast/podcastProvider.dart';
import 'package:podcastplayer/widget/playButton.dart';
import 'package:provider/provider.dart';

class ThePodCastPlayer extends StatefulWidget {
  List podCast;
  int index;
  ThePodCastPlayer({Key? key, required this.podCast, required this.index})
      : super(key: key);

  @override
  State<ThePodCastPlayer> createState() => _ThePodCastPlayerState();
}

class _ThePodCastPlayerState extends State<ThePodCastPlayer> {
  final PodCastController controller = Get.find();
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  Duration _duration = Duration();
  Duration _position = Duration();

  int ind = 0;
  bool _isPlaying = false;
  bool miniPlayer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void autoPlay() async {
    controller.audioPlay(widget.podCast[widget.index]['attributes']['file']
            ['data']['attributes']['url']
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    autoPlay();
    return SafeArea(
        child: GetBuilder<PodCastController>(
      init: PodCastController(),
      builder: (_) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                child: Text(widget.podCast[widget.index]['attributes']
                        ['SeriesName']
                    .toString()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Image.network(widget.podCast[widget.index]['attributes']
                        ['Banner']['data']['attributes']['formats']['thumbnail']
                        ['url']
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
                    String positionMin = controller.position.value
                        .toString()
                        .split('.')
                        .first
                        .split(':')[1];
                    String positionSec = controller.position.value
                        .toString()
                        .split('.')
                        .first
                        .split(':')
                        .last;
                    String totalMin = controller.totalDuration.value
                        .toString()
                        .split('.')
                        .first
                        .split(':')[1];
                    String totalSec = controller.totalDuration.value
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
              PlayButton(widget.podCast, widget.index),

              Container(
                child: IconButton(
                    onPressed: () {
                      int nextID = int.parse(
                          widget.podCast[widget.index]['id'].toString());
                    },
                    icon: Icon(Icons.skip_next)),
              )
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
        );
      },
    ));
  }

  void changeIndex(int i) {
    setState(() {
      ind = i;
    });
  }
}
