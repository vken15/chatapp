import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class InteractiveImage extends StatefulWidget {
  const InteractiveImage({super.key, required this.image});

  final Image image;

  @override
  State<InteractiveImage> createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  double _scale = 1.0;
  double? _previousScale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        //print(details);
        _previousScale = _scale;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        //print(details);
        setState(() => _scale = _previousScale! * details.scale);
      },
      onScaleEnd: (ScaleEndDetails details) {
        //print(details);
        _previousScale = null;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Transform(
              transform: Matrix4.diagonal3(vector.Vector3(_scale, _scale, _scale)),
              alignment: FractionalOffset.center,
              child: widget.image,
            ),
          ),
          IgnorePointer(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8),
                  BlendMode.srcOut),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode
                            .dstOut),
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
    );
  }
}
