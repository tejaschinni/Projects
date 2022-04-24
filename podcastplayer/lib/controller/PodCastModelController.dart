import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/model/podCastModel.dart';

class PodCastModelController extends GetxController {
  PodCastModel? podCastModel;
  var seriesName;
  var episodeNo;
  var url;
  var banner;
  var discrpition;
  var title;

  int currentTrackNo = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  getData(PodCastModel podCastModel) {
    for (var e in podCastModel.data) {
      seriesName = podCastModel
          .data[int.parse(e.toString())].attributes.seriesName
          .toString();
      episodeNo = podCastModel
          .data[int.parse(e.toString())].attributes.episodeNo
          .toString();
      banner = podCastModel.data[int.parse(e.toString())].attributes.banner.data
          .attributes.formats?.thumbnail.url
          .toString();

      discrpition = podCastModel
          .data[int.parse(e.toString())].attributes.description
          .toString();
      title =
          podCastModel.data[int.parse(e.toString())].attributes.name.toString();
    }
  }

  var sliderPosition = 0.0.obs;
  var sliverBeingMoved = false.obs;
  void setSliderPosition(double value) {
    sliderPosition.value = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData(podCastModel!);
  }

  var totalDuration = Duration.zero.obs;
  var position = Duration.zero.obs;
  //var audioState = AudioPlayerState.STOPPED.obs;

  void initAudio() async {
    await audioPlayer.setUrl('$url');
    await audioPlayer.setReleaseMode(ReleaseMode.STOP);
    audioPlayer.onDurationChanged.listen((event) {
      totalDuration.value = event;
      update();
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      position.value = event;
      if (event.inSeconds != 0 && !sliverBeingMoved.value) {
        // print(
        //'${event.inSeconds} : ${totalDuration.value.inSeconds} = ${event.inSeconds / totalDuration.value.inSeconds}');
        sliderPosition.value = event.inSeconds / totalDuration.value.inSeconds;
      }
      update();
      //sliderPosition.value = event.inSeconds / totalDuration.value.inSeconds;
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      //  audioState.value = event;
      update();
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      print('Finishedddddd');
    });
  }

  playAudio() async {
    int result = await audioPlayer.play('$url');
    if (result == 1) {
      print('Playing');
    }
  }

  pauseAudio() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      print('Paused');
    }
  }

  stopAudio() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      print('Stopped');
    }
  }

  seek(Duration duration) async {
    await audioPlayer.seek(duration);
  }

  void boom() {
    var currentValue = sliderPosition.value;
    var totalValue = totalDuration.value;
    var calculatedValue = (currentValue * totalValue.inSeconds).round();
    seek(Duration(seconds: calculatedValue));
    sliverBeingMoved.value = false;
    print('finished : $calculatedValue');
  }

  void itsMoving() {
    print("moving");
    sliverBeingMoved.value = true;
  }

  void nextSong() {
    if (currentTrackNo == podCastModel!.data.length - 1) {
      currentTrackNo = 0;
      changeSong(podCastModel!.data, currentTrackNo);
      print('Reset: $currentTrackNo');
    } else {
      int newTrackInt = currentTrackNo + 1;
      currentTrackNo++;
      changeSong(podCastModel!.data, newTrackInt);
      print('Next : $currentTrackNo');
    }
  }

  void changeSong(List<Datum> newpodcast, int index) async {
    await audioPlayer.stop();
    sliderPosition.value = 0.0;
    await audioPlayer
        .play(newpodcast[index].attributes.file.data.attributes.url);
    title.value = newpodcast[index].attributes.name;
    banner.value = newpodcast[index]
        .attributes
        .banner
        .data
        .attributes
        .formats
        ?.thumbnail
        .url;
    seriesName.value = newpodcast[index].attributes.seriesName;
    discrpition.value = newpodcast[index].attributes.seriesName;
    initAudio();
    print('Songggg: ${newpodcast[index].attributes.episodeNo}');
    update();
  }
}
