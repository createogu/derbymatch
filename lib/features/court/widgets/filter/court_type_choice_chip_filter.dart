import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/controllers/CommCodeController.dart';
import '../../controllers/CourtFilterController.dart';

class CourtTypeChoiceChipFilter extends ConsumerWidget {
  const CourtTypeChoiceChipFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List courtTypeList = CommCodeController.getCommCodesByType('courtType');
    final courtFilter = ref.watch(courtFilterProvider.notifier);
    final selectedCourtTypes = ref.watch(courtFilterProvider).court_type;

    return Wrap(
      alignment: WrapAlignment.start, // 왼쪽 정렬
      spacing: AppSpaceSize.smallSize,
      children: List<Widget>.generate(courtTypeList.length, (int index) {
        bool isSelected =
            selectedCourtTypes.contains(courtTypeList[index].comm_cd);
        return ChoiceChip(
          selectedColor: Pallete.primaryColor,
          side: isSelected ? null : BorderSide(color: Pallete.primaryColor),
          // 선택되지 않았을 때의 테두리 색상
          checkmarkColor: Pallete.whiteColor,
          // 체크 아이콘 색상
          label: Text(
            courtTypeList[index].comm_cd_nm,
            style: isSelected
                ? AppTextStyles.cautionTextStyle
                    .copyWith(color: Pallete.whiteColor)
                : AppTextStyles.cautionTextStyle
                    .copyWith(color: Pallete.primaryColor),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            courtFilter.updateCourtType(courtTypeList[index].comm_cd);
          },
        );
      }),
    );
  }
}
