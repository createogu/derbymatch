import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliderCaptionedImage extends StatelessWidget {
  final int index;
  final String caption;
  final String imageUrl;

  const SliderCaptionedImage(
      {Key? key,
      required this.index,
      required this.caption,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        child: Image(
          image: AssetImage(this.imageUrl),
          fit: BoxFit.contain,
        ),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: Text(
          caption,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
        ),
      ),
    ]);
  }
}
