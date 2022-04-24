// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';
import 'package:podcastplayer/customPodCast/podCast_api.dart';
import 'package:podcastplayer/customPodCast/theMiniPodCast.dart';
import 'package:podcastplayer/customPodCast/thePodCastPlayer.dart';
import 'package:provider/provider.dart';

class TheAllPodCast extends StatefulWidget {
  const TheAllPodCast({Key? key}) : super(key: key);

  @override
  State<TheAllPodCast> createState() => _TheAllPodCastState();
}

class _TheAllPodCastState extends State<TheAllPodCast> {
  List allPodCast = [];
  bool shouldRendere = false;
  PodCastAPI api = PodCastAPI();
  final PodCastController controller = Get.put(PodCastController());
  bool _isolying = false;
  int ind = 0;
  bool showingTrue = false;

  void getPodcast() async {
    allPodCast = await api.getAllPodCast();
    setState(() {
      shouldRendere = true;
    });
    print("All podCast Data  " + allPodCast.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPodcast();
    //isPlayingCheck();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.audioStop();
  }

  void isPlayingCheck() {
    print('0000');
    print(controller.audioState.value);
    if (controller.audioState.value == PlayerState.PLAYING) {
      setState(() {
        showingTrue = true;
      });
      print("Audio Is Playing ");
    } else if (controller.audioState.value == PlayerState.PAUSED) {
      setState(() {
        showingTrue = false;
      });
      print("Audio Is Playing pauseda ");
    } else {
      print("Audio Not Platying ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PodCastController>(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Podcast'),
            ),
            body: Column(children: [
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: allPodCast.length,
                      itemBuilder: (context, index) {
                        if (allPodCast[index]['attributes']['SeriesName'] ==
                            "Scaling Up with Dr. Yogesh Pawar") {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Image.network(allPodCast[index]['attributes']
                                        ['Banner']['data']['attributes']
                                    ['formats']['thumbnail']['url']),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(allPodCast[index]['attributes']
                                          ['Name']
                                      .toString()),
                                ),
                                Container(
                                  child: Text(
                                      allPodCast[index]['id'].toString() +
                                          "    INdex of podCast"),
                                )
                              ],
                            ),
                            onTap: () {
                              changeIndex(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThePodCastPlayer(
                                            podCast: allPodCast,
                                            index: index,
                                          )));
                            },
                          );
                        }
                        return Container();
                      })),
              Expanded(
                  child: Stack(
                children: [
                  controller.isPlying()
                      ? Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 100,
                            color: Colors.blueGrey,
                            // alignment: Alignment.bottomCenter,
                            child: TheMiniPodCast(
                              podcast: allPodCast,
                              index: ind,
                            ),
                          ),
                        )
                      : Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.transparent,
                          ),
                        ),
                ],
              ))
            ]),
            //  Stack(
            //   // overflow: Overflow.visible,
            //   // alignment: Alignment.center,
            //   children: [
            //     Expanded(
            //       // height: MediaQuery.of(context).size.height * 0.5,
            //       child: ListView.builder(
            //           shrinkWrap: true,
            //           scrollDirection: Axis.horizontal,
            //           itemCount: allPodCast.length,
            //           itemBuilder: (context, index) {
            //             if (allPodCast[index]['attributes']['SeriesName'] ==
            //                 "Scaling Up with Dr. Yogesh Pawar") {
            //               return GestureDetector(
            //                 child: Container(
            //                   color: Colors.yellow,
            //                   padding: EdgeInsets.all(10),
            //                   child: Column(
            //                     children: [
            //                       Image.network(allPodCast[index]
            //                                   ['attributes']['Banner']['data']
            //                               ['attributes']['formats']
            //                           ['thumbnail']['url']),
            //                       Container(
            //                         width: MediaQuery.of(context).size.width *
            //                             0.4,
            //                         child: Text(allPodCast[index]
            //                                 ['attributes']['Name']
            //                             .toString()),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   changeIndex(index);
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => ThePodCastPlayer(
            //                               podCast: allPodCast[index])));
            //                 },
            //               );
            //             }
            //             return Container();
            //           }),
            //     ),
            //     controller.isPlying()
            //         ? Positioned(
            //             bottom: 0,
            //             child: Container(
            //               width: MediaQuery.of(context).size.width,
            //               // height: 100,
            //               color: Colors.blueGrey,
            //               // alignment: Alignment.bottomCenter,
            //               child: TheMiniPodCast(podcast: allPodCast[ind]),
            //             ),
            //           )
            //         : Positioned(
            //             bottom: 0,
            //             child: Container(
            //               width: MediaQuery.of(context).size.width,
            //               height: 100,
            //               color: Colors.red,
            //             ),
            //           ),
            //   ],
            // )
          );
        },
      ),
    );
  }

  void changeIndex(int i) {
    setState(() {
      ind = i;
    });
  }
}
