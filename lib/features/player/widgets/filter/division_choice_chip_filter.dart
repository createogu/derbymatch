import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/controllers/CommCodeController.dart';
import '../../controllers/PlayerFilterController.dart';

class DivisionChoiceChipFilter extends ConsumerWidget {
  const DivisionChoiceChipFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List divisionList = CommCodeController.getCommCodesByType('division');
    final playerFilter = ref.watch(playerFilterProvider.notifier);
    final selectedDivisions = ref.watch(playerFilterProvider).division;

    return Wrap(
      alignment: WrapAlignment.start, // 왼쪽 정렬
      spacing: AppSpaceSize.smallSize,
      children: List<Widget>.generate(
        divisionList.length,
        (int index) {
          bool isSelected =
              selectedDivisions.contains(divisionList[index]['comm_cd']);
          return ChoiceChip(
            selectedColor: Pallete.primaryColor,
            side: isSelected ? null : BorderSide(color: Pallete.primaryColor),
            // 선택되지 않았을 때의 테두리 색상
            checkmarkColor: Pallete.whiteColor,
            // 체크 아이콘 색상
            label: Text(
              divisionList[index]['comm_cd_nm'],
              style: isSelected
                  ? AppTextStyles.cautionTextStyle
                      .copyWith(color: Pallete.whiteColor)
                  : AppTextStyles.cautionTextStyle
                      .copyWith(color: Pallete.primaryColor),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              playerFilter.updateDivision(divisionList[index]['comm_cd']);
            },
          );
        },
      ),
    );
  }
}
