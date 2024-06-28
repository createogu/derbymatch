import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/features/match/widgets/filter/match_type_choice_chip_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../controllers/match_filter_controller.dart';

class MatchFilterBottomSheet extends ConsumerStatefulWidget {
  final loadMatchs;

  const MatchFilterBottomSheet({required this.loadMatchs, super.key});

  @override
  ConsumerState<MatchFilterBottomSheet> createState() =>
      _MatchFilterBottomSheetState();
}

class _MatchFilterBottomSheetState
    extends ConsumerState<MatchFilterBottomSheet> {
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
                AppSpacesBox.verticalSpaceSmall,
                TitleDivider(title: '코트유형'),
                MatchTypeChoiceChipFilter(),
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
                          .read(matchFilterProvider.notifier)
                          .resetFilters(); // 필터 초기화 호출
                      widget.loadMatchs(); // 필요한 경우 플레이어 리스트 재로드
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
                      ref.read(matchFilterProvider.notifier).setPage(0);
                      widget.loadMatchs();
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
