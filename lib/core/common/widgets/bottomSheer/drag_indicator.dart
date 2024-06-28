import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class DragIndicator extends StatelessWidget {
  const DragIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpaceSize.mediumSize),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Pallete.primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppSpaceSize.mediumSize),
        ),
      ),
    );
  }
}
