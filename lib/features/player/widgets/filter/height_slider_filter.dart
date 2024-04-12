import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../controllers/PlayerFilterController.dart';

class HeightSliderFilter extends ConsumerWidget {
  const HeightSliderFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerFilter = ref.watch(playerFilterProvider);
    final playerFilterNotifier = ref.watch(playerFilterProvider.notifier);

    return Column(
      children: [
        Text(
          "${playerFilter.beginHeight.round()}cm - ${playerFilter.endHeight.round()}cm",
          style: AppTextStyles.bodyTextStyle,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.never, // 툴팁 라벨 숨기기
          ),
          child: RangeSlider(
            values:
                RangeValues(playerFilter.beginHeight, playerFilter.endHeight),
            min: 150,
            // 최소 키 값 설정
            max: 220,
            // 최대 키 값 설정
            divisions: 14,
            // 10cm 간격으로 눈금 표시
            activeColor: Pallete.primaryColor,
            // 활성화된 슬라이더의 색상
            inactiveColor: Colors.grey,
            // 비활성화된 슬라이더의 색상
            labels: RangeLabels(
              '${playerFilter.beginHeight.round()}cm',
              '${playerFilter.endHeight.round()}cm',
            ),
            onChanged: (RangeValues values) {
              // 사용자가 슬라이더를 조정할 때 호출됨
              playerFilterNotifier.updateHeightRange(values.start, values.end);
            },
          ),
        ),
      ],
    );
  }
}
