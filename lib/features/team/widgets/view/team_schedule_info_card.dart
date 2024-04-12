import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/controllers/CommCodeController.dart';
import '../../models/team_schedule_info_model.dart';

class TeamScheduleInfoCard extends ConsumerWidget {
  final TeamScheduleInfoModel teamScheduleInfoModel;

  const TeamScheduleInfoCard({
    super.key,
    required this.teamScheduleInfoModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commCodeController = ref.read(commCodeControllerProvider.notifier);

    return Container(
      margin: EdgeInsets.all(AppSpaceSize.smallSize),
      child: Padding(
        padding: EdgeInsets.all(AppSpaceSize.mediumSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Badge(
              largeSize: 21,
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
              label: Text(
                commCodeController.getCommCodeName(
                        'days', teamScheduleInfoModel.day_of_week) ??
                    '정보없음',
                style: AppTextStyles.infoTextStyle
                    .copyWith(color: Pallete.greyColor),
              ),
              backgroundColor: (teamScheduleInfoModel.day_of_week == '06' ||
                      teamScheduleInfoModel.day_of_week == '07')
                  ? Colors.red.withOpacity(0.1) // 주말은 빨간색
                  : Pallete.greyColor.withOpacity(0.1), // 평일은 회색
            ),
            AppSpacesBox.verticalSpaceMicro,
            Text(
              '${teamScheduleInfoModel.start_time} - ${teamScheduleInfoModel.end_time}',
              style: AppTextStyles.headlineTextStyle,
            ),
            AppSpacesBox.verticalSpaceMicro,
            Text(
              '${teamScheduleInfoModel.court_name}\n',
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // 긴 텍스트는 말줄임표로 표시
              style: AppTextStyles.infoTextStyle.copyWith(
                color: Pallete.greyColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
