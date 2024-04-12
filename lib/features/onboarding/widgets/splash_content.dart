import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.subText,
  }) : super(key: key);
  final String? text;
  final String? image;
  final String? subText;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Opacity(
              opacity: 1.0,
              child: Image.asset(
                widget.image!,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // 그라데이션 효과
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          // 텍스트 및 기타 내용
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(flex: 5),
                Text(
                  widget.text!,
                  style: AppTextStyles.headerTextStyle
                      .copyWith(color: Pallete.whiteColor),
                ),
                Text(
                  widget.subText!,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: Pallete.whiteColor),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
