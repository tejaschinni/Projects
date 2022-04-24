import 'package:get/get.dart';
import 'package:podcastplayer/customPodCast/podCast_api.dart';
import 'package:podcastplayer/model/podCastModel.dart';
import 'package:http/http.dart' as http;

class StreamPlayerPod extends GetxController {
  PodCastAPI api = PodCastAPI();
  var podList1 = PodCastModel.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getList();
  }

  void getList() async {
    var list = await api.getPodcast();

    podList1 = list;
  }
}
