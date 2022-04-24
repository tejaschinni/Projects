import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcastplayer/controller/podCastController.dart';

class MySlider extends StatelessWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
            trackHeight: 2,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
        child: GetBuilder<PodCastController>(
          builder: (controller) {
            return Slider(
              value: controller.sliderPosition.value,
              onChanged: (value) {
                controller.setSliderPosition(value);
              },
              onChangeEnd: (value) {
                controller.boom();
              },
              onChangeStart: (value) {
                controller.itsMoving();
              },
            );
          },
        ));
    ;
  }
}
