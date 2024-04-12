import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/controllers/CommCodeController.dart';
import '../../controllers/PlayerFilterController.dart';

class PositionChoiceChipFilter extends ConsumerWidget {
  const PositionChoiceChipFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List positionList = CommCodeController.getCommCodesByType('position');
    final playerFilter = ref.watch(playerFilterProvider.notifier);
    final selectedPositions = ref.watch(playerFilterProvider).positions;

    return Wrap(
      alignment: WrapAlignment.start, // 왼쪽 정렬
      spacing: AppSpaceSize.smallSize,
      children: List<Widget>.generate(positionList.length, (int index) {
        bool isSelected =
            selectedPositions.contains(positionList[index]['comm_cd']);
        return ChoiceChip(
          selectedColor: Pallete.primaryColor,
          side: isSelected ? null : BorderSide(color: Pallete.primaryColor),
          // 선택되지 않았을 때의 테두리 색상
          checkmarkColor: Pallete.whiteColor,
          // 체크 아이콘 색상
          label: Text(
            positionList[index]['comm_cd_nm'],
            style: isSelected
                ? AppTextStyles.cautionTextStyle
                    .copyWith(color: Pallete.whiteColor)
                : AppTextStyles.cautionTextStyle
                    .copyWith(color: Pallete.primaryColor),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            playerFilter.updatePositions(positionList[index]['comm_cd']);
          },
        );
      }),
    );
  }
}
