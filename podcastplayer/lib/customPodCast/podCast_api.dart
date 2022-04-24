import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:podcastplayer/model/podCastModel.dart';

class PodCastAPI {
  //   'https://api.siluniversity.com/api/podcasts?populate=*'
  //  'https://admin.siluniversity.com/api/podcasts?sort[0]=SeriesName'
  Future<List> getAllPodCast() async {
    var respoonse = await http.get(
        Uri.parse('https://api.siluniversity.com/api/podcasts?populate=*'));
    var body = json.decode(respoonse.body);
    return body['data'];
  }

  Future<PodCastModel> getPodcast() async {
    var respoonse = await http.get(
        Uri.parse('https://api.siluniversity.com/api/podcasts?populate=*'));
    var body = json.decode(respoonse.body);
    var podacast = PodCastModel.fromJson(body);
    // List<PodCastModel> podList = podacast.data.map()
    print(podacast.data.length.toString());
    return podacast;
  }
}
