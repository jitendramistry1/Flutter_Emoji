import 'package:flutter/material.dart';
import 'package:flutter_emoji/utils/colors_utils.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  //
  //Error Message Snackbar
  void error(String? message, int? second) {
    Get.snackbar("", "",
        duration: Duration(seconds: second ?? 2),
        isDismissible: false,
        messageText: const SizedBox.shrink(),
        colorText: Colors.black,
        backgroundColor: AppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        padding:
            const EdgeInsets.only(top: 15, left: 10, right: 20, bottom: 10),
        borderRadius: 0,
        margin: const EdgeInsets.all(0),
        icon: const Icon(Icons.error, color: AppColors.bgwhite),
        titleText: Text(
          message ?? "error occurred",
          style: const TextStyle(
            color: AppColors.bgwhite,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  void success(String? message, int? second) {
    Get.snackbar("", "",
        duration: Duration(seconds: second ?? 2),
        isDismissible: false,
        messageText: const SizedBox.shrink(),
        colorText: Colors.black,
        backgroundColor: AppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        padding:
            const EdgeInsets.only(top: 15, left: 10, right: 20, bottom: 10),
        borderRadius: 0,
        margin: const EdgeInsets.all(0),
        icon: const Icon(Icons.thumb_up, color: AppColors.bgwhite),
        titleText: Text(
          message ?? "Success",
          style: const TextStyle(
            color: AppColors.bgwhite,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
