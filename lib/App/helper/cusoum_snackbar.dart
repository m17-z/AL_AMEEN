
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomSnackBar {
  static String message = '';

  static void defaultSnackBar({
    String? title,
    required String message,
    ContentType? contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title ?? '',
        message: message,
        contentType: contentType ?? ContentType.help,
      ),
    );

    ScaffoldMessenger.of(Get.overlayContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void error({
    String? title = 'Error',
    required String message,
  }) {
    defaultSnackBar(
      title: title,
      message: message,
      contentType: ContentType.failure,
    );
  }

  static void warning({
    String? title = 'Warning',
    required String message,
  }) {
    defaultSnackBar(
      title: title,
      message: message,
      contentType: ContentType.warning,
    );
  }

  static void success({
    String? title = 'Success',
    required String message,
  }) {
    defaultSnackBar(
      title: title,
      message: message,
      contentType: ContentType.success,
    );
  }
}
