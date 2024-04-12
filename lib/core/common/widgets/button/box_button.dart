import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class BoxButton extends StatelessWidget {
  const BoxButton({
    required this.child,
    this.color,
    this.disableColor,
    this.elevation,
    this.width,
    this.side = BorderSide.none,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color? color;
  final Color? disableColor;
  final double? elevation;
  final double? width;
  final BorderSide side;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 1,
          color: Pallete.whiteColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextButton(
          onPressed: onTap,
          child: child,
        ),
      ),
    );
  }
}
