import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../data/api/constance.dart';




class CustomWaves {

  static Container
  waveStyle(
      {
        String? text,
        Color? colorButton = Constants.primaryColor,
        Function()? onPressed,
        double? borderSize = 8,
        double? width,
        double? height,
        Color? colorText= Colors.white
      })
  {
    return   Container(
      width: Get.width,
      height: Get.height,
      alignment: Alignment.bottomCenter,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Colors.orange , Constants.primaryColor],
            [Colors.orange[800]!, Constants.primaryColor],
            [Colors.orangeAccent, Constants.primaryColor],
          ],
          durations: [ 5000,5000 ,5000 ],
          heightPercentages: [0.15, 0.23, 0.30],
          // blur: MaskFilter.blur(BlurStyle.solid, 10),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 1,
        size: Size(
          Get.width,
          Get.height*.07,
        ),
      ),
    );
  }
}



