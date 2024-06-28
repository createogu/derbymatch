import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  final String? subTitle;
  final leadingButton;

  const TitleDivider(
      {required this.title, this.subTitle, this.leadingButton, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headlineTextStyle,
                ),
                if (subTitle != null)
                  Text(
                    subTitle.toString(),
                    style: AppTextStyles.descriptionTextStyle
                        .copyWith(color: Pallete.greyColor.withOpacity(0.5)),
                  ),
              ],
            ),
            if (leadingButton != null) leadingButton,
          ],
        ),
        AppSpacesBox.verticalSpaceSmall,
      ],
    );
  }
}
