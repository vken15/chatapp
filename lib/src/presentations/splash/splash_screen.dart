import 'package:chatapp/src/presentations/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Image.asset("assets/icons/chat_icon.png")),
          const Center(
            child: Text(
              "CHAT APP",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
            child: const CircularProgressIndicator(
            ),
          )
        ],
      ),
    );
  }
}
