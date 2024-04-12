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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Badge(
                            largeSize: 20,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSpaceSize.mediumSize),
                            label: Text(
                              CommCodeController.getCommCodeName(
                                      'division', team.division) ??
                                  '정보없음',
                              style: AppTextStyles.descriptionTextStyle
                                  .copyWith(color: Pallete.greyColor),
                            ),
                            backgroundColor: Pallete.blueColor.withOpacity(0.2),
                          ),
                          AppSpacesBox.horizontalSpaceMicro,
                          Badge(
                            largeSize: 20,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSpaceSize.smallSize),
                            label: Text(
                              team.addressName,
                              style: AppTextStyles.descriptionTextStyle
                                  .copyWith(color: Pallete.greyColor),
                            ),
                            backgroundColor: Pallete.greyColor.withOpacity(0.1),
                          ),
                        ],
                      ),
                      AppSpacesBox.verticalSpaceMicro,
                      Row(
                        children: [
                          Text(team.name, style: AppTextStyles.bodyTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '학하동 DB프로미 체육관',
                            style: AppTextStyles.descriptionTextStyle.copyWith(
                              color: Pallete.greyColor.withOpacity(0.5),
                            ),
                          ),
                          AppSpacesBox.horizontalSpaceMicro,
                          Text(
                            '월, 20~23',
                            style: AppTextStyles.descriptionTextStyle.copyWith(
                              color: Pallete.greyColor.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Positioned(
        //   top: 0,
        //   right: 0,
        //   child: IconButton(
        //     icon: const Icon(Icons.more_horiz, color: Pallete.primaryColor),
        //     onPressed: () {
        //       // 여기에서 team의 id를 이용하여 라우트 경로를 구성합니다.
        //       Routemaster.of(context).push('/team/${team.id}');
        //     },
        //   ),
        // ),
      ),
    );
  }
}
