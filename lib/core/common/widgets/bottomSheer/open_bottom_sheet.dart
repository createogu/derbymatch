import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';
import '../../../values/values.dart';

class OpenBottomSheet extends StatelessWidget {
  final Widget child;
  final double heightRatio;
  final String buttonText;
  final TextStyle? textStyle;

  const OpenBottomSheet({
    required this.child,
    this.heightRatio = 0.8,
    this.buttonText = '수정',
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _openBottomSheet(context);
      },
      child: Text(
        buttonText,
        style: textStyle ??
            AppTextStyles.infoTextStyle.copyWith(color: Pallete.greyColor),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: heightRatio,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return child;
        });
  }
}
