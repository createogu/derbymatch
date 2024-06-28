import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';
import '../../../values/values.dart';

class ScrollTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final double parentHeight; // 부모 창 높이를 받기 위한 변수

  const ScrollTextFormField({
    required this.controller,
    required this.parentHeight, // 생성자를 통해 부모 창 높이를 전달받음
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: parentHeight / 3, // 부모 창 높이를 사용하여 높이 설정
      padding: EdgeInsets.all(AppSpaceSize.smallSize),
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.greyColor),
        borderRadius: BorderRadius.circular(AppSpaceSize.smallSize),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TextField(
          controller: controller,
          autofocus: true,
          style: AppTextStyles.infoTextStyle,
          decoration: AppInputStyles.noLineFormFieldStyle.copyWith(
            hintText: '내용을 입력해주세요.',
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
    );
  }
}
