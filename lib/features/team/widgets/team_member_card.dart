import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/team/models/team_member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/image/common_circle_image_view.dart';
import '../../../core/common/controllers/CommCodeController.dart';

class TeamMemberCard extends ConsumerWidget {
  const TeamMemberCard({
    super.key,
    required this.teamMember,
  });

  final TeamMemberModel teamMember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonCircleImageView(
                      profileImage: teamMember.profile_image,
                      radius: 25,
                      userName: teamMember.name,
                    ),
                    AppSpacesBox.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                teamMember.gender_cd == '01'
                                    ? Icons.male
                                    : Icons.female,
                                size: 16,
                                color: teamMember.gender_cd == '01'
                                    ? Pallete.blueColor
                                    : Pallete.redColor,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(teamMember.name,
                                  style: AppTextStyles.bodyTextStyle),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${teamMember.player_number.toString()}번',
                                style: AppTextStyles.infoTextStyle.copyWith(
                                  color: Pallete.greyColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          AppSpacesBox.verticalSpaceMicro,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(teamMember.height.toString(),
                                  style: AppTextStyles.descriptionTextStyle
                                      .copyWith(
                                    color: Pallete.greyColor.withOpacity(0.5),
                                  )),
                              Text('cm',
                                  style: AppTextStyles.descriptionTextStyle
                                      .copyWith(
                                    color: Pallete.greyColor.withOpacity(0.5),
                                  )),
                              AppSpacesBox.horizontalSpaceMicro,
                              Text(teamMember.weight.toString(),
                                  style: AppTextStyles.descriptionTextStyle
                                      .copyWith(
                                    color: Pallete.greyColor.withOpacity(0.5),
                                  )),
                              Text('kg',
                                  style: AppTextStyles.descriptionTextStyle
                                      .copyWith(
                                    color: Pallete.greyColor.withOpacity(0.5),
                                  )),
                            ],
                          ),
                          AppSpacesBox.verticalSpaceSmall,
                          Row(
                            children: [
                              Wrap(
                                spacing: AppSpaceSize.smallSize,
                                children: teamMember.positions
                                    .map(
                                      (position) => Badge(
                                        largeSize: 20,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppSpaceSize.smallSize),
                                        label: Text(
                                          position,
                                          style: AppTextStyles.cautionTextStyle
                                              .copyWith(
                                                  color: Pallete.greyColor),
                                        ),
                                        backgroundColor:
                                            Pallete.greyColor.withOpacity(0.1),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: AppSpaceSize.mediumSize,
          top: AppSpaceSize.smallSize,
          child: teamMember.role != '03'
              ? Badge(
                  largeSize: 20,
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSpaceSize.smallSize),
                  label: Text(
                    CommCodeController.getCommCodeName(
                            'role', teamMember.role) ??
                        '정보없음',
                    style: AppTextStyles.cautionTextStyle
                        .copyWith(color: Pallete.greyColor),
                  ),
                  backgroundColor: Pallete.greyColor.withOpacity(0.1),
                )
              : Container(),
        ),
        Positioned(
          right: AppSpaceSize.smallSize,
          bottom: 0,
          child: Container(
            width: 40, // 적절한 크기로 조절
            height: 30, // 적절한 크기로 조절
            child: IconButton(
              padding: EdgeInsets.zero, // Padding 제거
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
            ),
          ),
        )
      ],
    );
  }
}
