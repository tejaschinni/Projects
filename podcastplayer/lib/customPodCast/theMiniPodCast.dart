import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';
import 'package:podcastplayer/customPodCast/mySlider.dart';
import 'package:podcastplayer/customPodCast/nowPlaying.dart';
import 'package:podcastplayer/customPodCast/thePodCastPlayer.dart';
import 'package:podcastplayer/widget/playButton.dart';

class TheMiniPodCast extends StatefulWidget {
  List podcast;
  int index;
  TheMiniPodCast({Key? key, required this.podcast, required this.index})
      : super(key: key);

  @override
  State<TheMiniPodCast> createState() => _TheMiniPodCastState();
}

class _TheMiniPodCastState extends State<TheMiniPodCast> {
  final PodCastController controller = Get.put(PodCastController());
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  bool _isPlaying = false;
  int nextIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextIndex = widget.index;
    print(nextIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodCastController>(
      builder: (_) {
        return Row(
          children: [
            GestureDetector(
              child: Image.network(
                widget.podcast[nextIndex]['attributes']['Banner']['data']
                        ['attributes']['formats']['thumbnail']['url']
                    .toString(),
                scale: 1.5,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NowPlaying(widget.podcast, nextIndex)));
              },
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.skip_previous,
                  size: 40,
                )),
            Spacer(),
            PlayButton(widget.podcast, nextIndex),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    nextIndex = widget.index + 1;
                  });
                  print(nextIndex.toString() + 'next audio fule called');
                  print(widget.index.toString() + 'previous audio fule called');

                  changeAudio(nextIndex);
                },
                icon: Icon(
                  Icons.skip_next,
                  size: 40,
                )),
          ],
        );
      },
    );
  }

  void changeAudio(int index) {
    // setState(() {
    //   index = index + 1;
    // });
    controller.audioStop();
    controller.audioPlay(widget.podcast[index]['attributes']['file']['data']
            ['attributes']['url']
        .toString());
    print(widget.podcast[index]['attributes']['Name'].toString() +
        "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
  }
}
