import 'package:derbymatch/core/common/widgets/image/common_rectangle_image_view.dart';
import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../models/team_model.dart';

class TeamCard extends ConsumerWidget {
  const TeamCard({
    super.key,
    required this.team,
  });

  final TeamModel team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push('/team/${team.team_id}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Pallete.greyColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(
            AppSpaceSize.mediumSize,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CommonSquareImageView(
                        profile_image: team.team_logo_image,
                        size: 55,
                        userName: team.name,
                      ),
                    ],
                  ),
                  AppSpacesBox.horizontalSpaceSmall,
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(team.name, style: AppTextStyles.bodyTextStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Badge(
                              largeSize: 16,
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSpaceSize.smallSize),
                              label: Text(
                                CommCodeController.getCommCodeName(
                                        'division', team.division) ??
                                    '정보없음',
                                style: AppTextStyles.descriptionTextStyle
                                    .copyWith(color: Pallete.primaryColor),
                              ),
                              backgroundColor:
                                  Pallete.primaryColor.withOpacity(0.1),
                            ),
                            AppSpacesBox.horizontalSpaceMicro,
                            Badge(
                              largeSize: 16,
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSpaceSize.smallSize),
                              label: Text(
                                team.addressName,
                                style: AppTextStyles.descriptionTextStyle
                                    .copyWith(color: Pallete.greyColor),
                              ),
                              backgroundColor:
                                  Pallete.greyColor.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacesBox.verticalSpaceMicro,
              Text(
                '학하동 DB프로미 체육관',
                style: AppTextStyles.cautionTextStyle.copyWith(
                  color: Pallete.greyColor,
                ),
              ),
              AppSpacesBox.horizontalSpaceMicro,
              Text(
                '월, 20~23',
                style: AppTextStyles.cautionTextStyle.copyWith(
                  color: Pallete.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
