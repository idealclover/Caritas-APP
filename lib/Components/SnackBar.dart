import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MSnackBar {
  static showSnackBar(String title, String subtitle) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Colors.white,
        messageText: subtitle == "" ? Container() : null,
        duration: const Duration(seconds: 1));
  }
}
