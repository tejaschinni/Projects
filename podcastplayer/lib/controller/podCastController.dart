import 'package:audioplayers/audioplayers.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:podcastplayer/model/podCastModel.dart';

class PodCastController extends GetxController {
  AudioPlayer _audioPlayer = AudioPlayer();
  Duration duration = Duration(seconds: 0);
  PodCastModel? podCastModel;

  // Duration position = Duration(seconds: 0);

  var totalDuration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var audioState = PlayerState.STOPPED.obs;
  int currentTrackNo = 0;

  var sliderPosition = 0.0.obs;
  var sliverBeingMoved = false.obs;
  void setSliderPosition(double value) {
    sliderPosition.value = value;
    update();
  }

  void boom() {
    var currentValue = sliderPosition.value;
    var totalValue = totalDuration.value;
    var calculatedValue = (currentValue * totalValue.inSeconds).round();
    seek(Duration(seconds: calculatedValue));
    sliverBeingMoved.value = false;
    print('finished : $calculatedValue');
  }

  seek(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  void initAudio() async {
    // await _audioPlayer.setUrl('$songURL');
    // await _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    _audioPlayer.onDurationChanged.listen((event) {
      totalDuration.value = event;
      update();
    });

    _audioPlayer.onAudioPositionChanged.listen((event) {
      position.value = event;
      if (event.inSeconds != 0 && !sliverBeingMoved.value) {
        // print(
        //'${event.inSeconds} : ${totalDuration.value.inSeconds} = ${event.inSeconds / totalDuration.value.inSeconds}');
        sliderPosition.value = event.inSeconds / totalDuration.value.inSeconds;
      }
      update();
      //sliderPosition.value = event.inSeconds / totalDuration.value.inSeconds;
    });

    _audioPlayer.onPlayerStateChanged.listen((event) {
      audioState.value = event;
      print("00000000000" + event.name);
      update();
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      print('Finishedddddd');
    });
  }

  bool isPlying() {
    if (audioState.value == PlayerState.PLAYING) {
      return true;
    } else if (audioState.value == PlayerState.PAUSED) {
      return true;
    } else {
      return false;
    }
  }

  void itsMoving() {
    print("moving");
    sliverBeingMoved.value = true;
  }

  void audioStop() {
    _audioPlayer.stop();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initAudio();
  }

  void audioPlay(String url) {
    _audioPlayer.play(url);
    update();
  }

  void audioPause() {
    _audioPlayer.pause();
    update();
  }

  void audioDispose() {
    _audioPlayer.dispose();
    update();
  }

  void getDuration() {
    _audioPlayer.onDurationChanged.listen((event) {
      duration = event;
    });
  }

  int currentno = 0;

  void nextSong(List podcastList, int index) {
    print(podcastList.length.toString() + "length of list pass to controller");
    print(index.toString() + 'index passend to function');
    // if (index == podCastModel!.data.length - 1) {
    //   index = 0;
    //   changeSong(podcastList, index);
    // } else {
    //   changeSong(podcastList, index);
    // }
  }

  void changeSong(List newTrack, int index) async {
    await _audioPlayer.stop();
    sliderPosition.value = 0.0;
    await _audioPlayer.play(newTrack[index]['attributes']['file']['data']
            ['attributes']['url']
        .toString());
    initAudio();
    update();
  }
}
