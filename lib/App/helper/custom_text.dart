import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/api/constance.dart';

class CustomText extends StatelessWidget{

 final String? text;
 final String? fontFamily;
 final EdgeInsetsGeometry? padding;
 final double? fontsize;
 final Decoration? decoration;
 final double? widthController;
 final double? heightController;
 Color? color =Get.isDarkMode ?  Colors.white:Colors.black;
 Alignment? alignment= Get.locale==const Locale('ar')? Alignment.topRight:Alignment.topLeft;
 final FontWeight? fontWeight;
 final int? maxLines;
 final  double? height;
  double? wordSpacing;
  final Color? colorContainer;

 CustomText( {super.key,
   this.text='',
   this.fontsize= 15,
   this.color,
   this.alignment,
   this.fontWeight= FontWeight.bold,
   this.maxLines = 10000,
   this.height= 1.3,
   this.wordSpacing, this.widthController, this.heightController, this.decoration, this.colorContainer, this.padding, this.fontFamily = 'Catamaran',});


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: widthController ,
      height:heightController ,
      decoration: decoration,
      color: colorContainer,
      padding: padding,
      child:  Text(
        text.toString().tr,
        maxLines: maxLines,
        textAlign: TextAlign.start,
        style: TextStyle(
          overflow: TextOverflow.fade,
          fontFamily: fontFamily,
          wordSpacing: wordSpacing,
          height: height,
          fontSize: fontsize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
  }


