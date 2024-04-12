import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../controllers/PlayerFilterController.dart';
import 'filter/division_choice_chip_filter.dart';
import 'filter/gender_choice_chip_filter.dart';
import 'filter/height_slider_filter.dart';
import 'filter/position_choice_chip_filter.dart';
import 'filter/weight_slider_filter.dart';

class PlayerFilterBottomSheet extends ConsumerStatefulWidget {
  final loadPlayers;

  const PlayerFilterBottomSheet({required this.loadPlayers, super.key});

  @override
  ConsumerState<PlayerFilterBottomSheet> createState() =>
      _PlayerFilterBottomSheetState();
}

class _PlayerFilterBottomSheetState
    extends ConsumerState<PlayerFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
        left: AppSpaceSize.mediumSize,
        right: AppSpaceSize.mediumSize,
        top: AppSpaceSize.mediumSize,
      ),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppSpacesBox.verticalSpaceMedium,
                TitleDivider(title: '성별'),
                GenderChoiceChipFilter(),
                AppSpacesBox.verticalSpaceSmall,
                TitleDivider(title: '부종'),
                DivisionChoiceChipFilter(),
                AppSpacesBox.verticalSpaceSmall,
                TitleDivider(title: '포지션'),
                PositionChoiceChipFilter(),
                AppSpacesBox.verticalSpaceSmall,
                TitleDivider(title: '키'),
                HeightSliderFilter(),
                AppSpacesBox.verticalSpaceSmall,
                TitleDivider(title: '체중'),
                WeightSliderFilter(),
                SizedBox(height: 80), // 버튼의 고정된 위치를 고려한 여백
              ],
            ),
          ),
          Positioned(
            left: AppSpaceSize.mediumSize,
            right: AppSpaceSize.mediumSize,
            bottom: AppSpaceSize.largeSize,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(playerFilterProvider.notifier)
                          .resetFilters(); // 필터 초기화 호출
                      widget.loadPlayers(); // 필요한 경우 플레이어 리스트 재로드
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '초기화',
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: Pallete.primaryColor),
                    ),
                    style: ButtonStyles.seconderyButton,
                  ),
                ),
                AppSpacesBox.horizontalSpaceMicro,
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(playerFilterProvider.notifier).setPage(0);
                      widget.loadPlayers();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '필터 적용',
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: Pallete.whiteColor),
                    ),
                    style: ButtonStyles.primaryButton,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
