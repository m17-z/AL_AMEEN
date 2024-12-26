
import 'package:flutter/material.dart';

extension padding on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}


const String baseUrLinkTest = "http://192.168.0.45:7005/RestfulApp/resources/generatetoken/OpenSession";
