
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:get/get.dart';

import '../data/api/constance.dart';


class CustomTextFormField {
  static SizedBox
  textFieldStyle(
      {String labelText = "",
        String hintText = "",
        double? width,
        double? height,
        bool obscureText = false,
        Widget? suffixIcon,
        double fontSize= 15,
        TextAlign textAlign = TextAlign.start,
        FontWeight fontWeight =FontWeight.w300,
        Color? hintColor,
        InputBorder? border,
        Null Function(dynamic value)? onSaved,
        Null Function(dynamic value)? onChanged,
        TextEditingController? controller,
        String? Function(dynamic value)? validator,
        TextInputType keyboardType=TextInputType.emailAddress,
        int? maxLength, List<FilteringTextInputFormatter>? inputFormatters,
        })
  {

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        textAlign: textAlign,
        onSaved: onSaved,
        maxLength: maxLength ,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        validator:validator ,
        textDirection: Get.locale==const Locale('ar')? TextDirection.rtl : TextDirection.ltr,
        controller: controller,
        cursorColor: Constants.fontColor,


        decoration: InputDecoration(
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),

          suffixIcon:suffixIcon,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // تغيير لون الحدود عند التركيز
          ),
         // filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w100),
        ),
      ),
    );
  }
}

