import 'package:chatapp/src/components/app_button.dart';
import 'package:chatapp/src/components/interactive_image.dart';
import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/presentations/profile/controllers/change_photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePhotoScreen extends GetWidget<ChangePhotoController> {
  const ChangePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật ảnh đại diện"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: context.isDarkMode ? [const Color.fromARGB(96, 43, 42, 42), const Color.fromARGB(96, 43, 42, 42)] : 
                [const Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
          ),
        ),
      ),
      body: Obx(
        () => controller.selectedImage.value == null
            ? const Center()
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(color: Colors.black),
                  Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).width,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: InteractiveImage(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Text(//Bạn có thể di chuyển hoặc zoom ảnh
                      "Bạn có thể di chuyển ảnh",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  controller.screenState.value == AppState.loading ? 
                  Center(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: const CircularProgressIndicator()),
                  )
                  : Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonCustom(
                          onPressed: () {
                            controller.imageDisplay =
                                MediaQuery.sizeOf(context).width - 20;
                            controller.saveImage();
                          },
                          text: "Xong",
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
