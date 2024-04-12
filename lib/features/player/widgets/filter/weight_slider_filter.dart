import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../controllers/PlayerFilterController.dart';

class WeightSliderFilter extends ConsumerWidget {
  const WeightSliderFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerFilter = ref.watch(playerFilterProvider);
    final playerFilterNotifier = ref.watch(playerFilterProvider.notifier);

    return Column(
      children: [
        Text(
          "${playerFilter.beginWeight.round()}kg - ${playerFilter.endWeight.round()}kg",
          style: AppTextStyles.bodyTextStyle,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.never, // 툴팁 라벨 숨기기
          ),
          child: RangeSlider(
            values:
                RangeValues(playerFilter.beginWeight, playerFilter.endWeight),
            min: 50,
            // 최소 무게 값 설정
            max: 150,
            // 최대 무게 값 설정
            divisions: 20,
            // 1kg 간격으로 눈금 표시
            activeColor: Pallete.primaryColor,
            // 활성화된 슬라이더의 색상
            inactiveColor: Colors.grey,
            // 비활성화된 슬라이더의 색상
            labels: RangeLabels(
              '${playerFilter.beginWeight.round()}kg',
              '${playerFilter.endWeight.round()}kg',
            ),
            onChanged: (RangeValues values) {
              // 사용자가 슬라이더를 조정할 때 호출됨
              playerFilterNotifier.updateWeightRange(values.start, values.end);
            },
          ),
        ),
      ],
    );
  }
}
