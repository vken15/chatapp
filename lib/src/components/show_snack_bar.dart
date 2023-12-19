import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static void showSnackBar(String? message) {
    Get.snackbar(
      "Lỗi",
      message ?? "",
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      backgroundColor: Colors.black.withOpacity(0.5),
    );
  }
}