import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBoxController extends GetxController {
  Rx<TextEditingController> message = Rx(TextEditingController());
}