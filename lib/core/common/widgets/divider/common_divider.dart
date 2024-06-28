import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';
import '../../../values/values.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppSpaceSize.mediumSize,
          horizontal: AppSpaceSize.mediumSize),
      child: Divider(
        color: Pallete.greyColor.withOpacity(0.1),
      ),
    );
  }
}
