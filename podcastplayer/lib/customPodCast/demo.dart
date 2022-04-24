import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/PodCastModelController.dart';
import 'package:podcastplayer/customPodCast/podCast_api.dart';
import 'package:podcastplayer/model/podCastModel.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  PodCastAPI api = PodCastAPI();
  PodCastModel? podcast;
  PodCastModel? podlist;
  List<PodCastModel> pod = [];
  Map<String, dynamic> mp = {};
  List<PodCastModel> podList = [];
  bool shouldRender = false;

  var defauiltSong;

  void getData() async {
    podcast = await api.getPodcast();
    //  podcast!.map((jsonMap) => PodCastModel.obs.fromJson(jsonMap)).toList();

    setState(() {
      shouldRender = true;
      defauiltSong = podcast!.data[0];
    });
    if (podcast!.data[2].attributes.seriesName
        .contains("Scaling Up with Dr. Yogesh Pawar")) {
      print(podcast!.data[3].attributes.name.toString());
    } else {
      print('Does not contain');
    }
    print("List Of PodCast" + podlist.toString());
  }

  PodCastModelController? podController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    podController = Get.put(PodCastModelController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Player"),
      ),
      body: Column(
        children: [
          Expanded(
              child: shouldRender
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: podcast!.data.length,
                      itemBuilder: ((context, index) {
                        if (podcast!.data[index].attributes.seriesName ==
                            "Scaling Up with Dr. Yogesh Pawar") {
                          return Container(
                            child: Text(podcast!.data[index].id.toString()),
                          );
                        }
                        // if (podcast!.data[index].attributes.seriesName ==
                        //     "\"Roadmap to Striking More Deals\"  with Dr. Akshay Seth") {
                        //   return Container(
                        //     child: Text(podcast!.data[index].id.toString()),
                        //   );
                        // }
                        return _ListBuilder(podcast!);
                      }))
                  : Container(
                      child: Text('Lodaing'),
                    ))
        ],
      ),
    );
  }

  Widget _ListBuilder(PodCastModel podCastModel) {
    return Container();
  }
}
