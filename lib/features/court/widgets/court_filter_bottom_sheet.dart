import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/features/court/widgets/filter/court_type_choice_chip_filter.dart';
import 'package:derbymatch/features/court/widgets/filter/court_type_detail_choice_chip_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../controllers/CourtFilterController.dart';

class CourtFilterBottomSheet extends ConsumerStatefulWidget {
  final loadCourts;

  const CourtFilterBottomSheet({required this.loadCourts, super.key});

  @override
  ConsumerState<CourtFilterBottomSheet> createState() =>
      _CourtFilterBottomSheetState();
}

class _CourtFilterBottomSheetState
    extends ConsumerState<CourtFilterBottomSheet> {
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
                CourtTypeChoiceChipFilter(),
                TitleDivider(title: '코트타입'),
                CourtTypeDetailChoiceChipFilter(),
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
                          .read(courtFilterProvider.notifier)
                          .resetFilters(); // 필터 초기화 호출
                      widget.loadCourts(); // 필요한 경우 플레이어 리스트 재로드
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
                      ref.read(courtFilterProvider.notifier).setPage(0);
                      widget.loadCourts();
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
