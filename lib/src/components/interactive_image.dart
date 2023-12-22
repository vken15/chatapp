import 'package:chatapp/src/presentations/profile/controllers/change_photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:vector_math/vector_math_64.dart' as vector;

class InteractiveImage extends GetWidget<ChangePhotoController> {
  const InteractiveImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        // onScaleStart: (ScaleStartDetails details) {
        //   //print(details);
        //   controller.previousScale.value = controller.scale.value;
        // },
        // onScaleUpdate: (ScaleUpdateDetails details) {
        //   //print(details.scale);
        //   if (controller.previousScale.value * details.scale >= 1.0 && controller.previousScale.value * details.scale <= 2.0) {
        //     controller.scale.value =
        //         controller.previousScale.value * details.scale;
        //   print(controller.scale.value);
        //   }
        // },
        // onScaleEnd: (ScaleEndDetails details) {
        //   //print(details);
        //   controller.previousScale.value = -1;
        // },
        child: Stack(
          children: [//InteractiveViewer
            SingleChildScrollView(
              controller: controller.scrollController,
              scrollDirection: controller.scrollVertical.value == true ? Axis.vertical : Axis.horizontal,
              // child: Transform(
              //   transform: Matrix4.diagonal3(vector.Vector3(
              //       controller.scale.value,
              //       controller.scale.value,
              //       controller.scale.value)),
              //   alignment: FractionalOffset.center,
                child: Image.file(
                  controller.selectedImage.value!,
                  fit: BoxFit.fitWidth,
                ),
              //),
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
