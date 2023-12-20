import 'package:chatapp/src/components/app_button.dart';
import 'package:chatapp/src/components/interactive_image.dart';
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
                      height: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InteractiveImage(
                          image: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "Bạn có thể di chuyển hoặc zoom ảnh",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonCustom(
                        onPressed: () {
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
