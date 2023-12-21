import 'package:chatapp/src/presentations/profile/controllers/change_photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class InteractiveImage extends GetWidget<ChangePhotoController> {
  const InteractiveImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          //print(details);
          controller.previousScale.value = controller.scale.value;
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          //print(details);
          if (controller.previousScale.value != null) {
            controller.scale.value =
                controller.previousScale.value! * details.scale;
          }
        },
        onScaleEnd: (ScaleEndDetails details) {
          //print(details);
          controller.previousScale.value = null;
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller.scrollController,
              child: Transform(
                transform: Matrix4.diagonal3(vector.Vector3(
                    controller.scale.value,
                    controller.scale.value,
                    controller.scale.value)),
                alignment: FractionalOffset.center,
                child: Image.file(
                  controller.selectedImage.value!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IgnorePointer(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.srcOut),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          backgroundBlendMode: BlendMode.dstOut),
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
