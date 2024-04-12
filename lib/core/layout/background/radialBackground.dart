import 'package:flutter/material.dart';

import '../../values/values.dart';

// ignore: must_be_immutable
class RadialBackground extends StatelessWidget {
  final String position;
  final Color color;
  var list = List.generate(
    1,
    (index) => HexColor.fromHex("1D192D"),
  );

  RadialBackground({required this.color, required this.position});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [...list, this.color],
            center: (position == "bottomRight")
                ? Alignment(0.5, 1.0)
                : Alignment(-1.0, -1.0),
          ),
        ),
      ),
    );
  }
}
