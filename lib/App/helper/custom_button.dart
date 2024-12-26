import 'package:flutter/material.dart';
import '../data/api/constance.dart';
import 'custom_text.dart';



class CustomButton {

  static SizedBox
  buttonStyle(
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
    return SizedBox(
      width: width,
      height:height ,
      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderSize!)),
        onPressed: onPressed,
        color: colorButton,
        child: CustomText(
          text: text,
          fontsize: 18,
          color: colorText,
        ),
      ),
    );
  }
}




