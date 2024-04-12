import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/common/widgets/image/common_circle_image_view.dart';
import '../models/player_model.dart';

class PlayerCard2 extends StatelessWidget {
  const PlayerCard2({
    super.key,
    required this.player,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpaceSize.largeSize,
              AppSpaceSize.largeSize,
              AppSpaceSize.largeSize,
              AppSpaceSize.smallSize,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonCircleImageView(
                      profileImage: player.profile_image,
                      radius: 40,
                      userName: player.name,
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
                                player.gender_cd == '01'
                                    ? Icons.male
                                    : Icons.female,
                                size: 16,
                                color: player.gender_cd == '01'
                                    ? Pallete.blueColor
                                    : Pallete.redColor,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(player.name,
                                  style: AppTextStyles.bodyTextStyle),
                            ],
                          ),
                          AppSpacesBox.verticalSpaceMicro,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(player.height.toString(),
                                  style: AppTextStyles.infoTextStyle),
                              Text('cm', style: AppTextStyles.cautionTextStyle),
                              AppSpacesBox.horizontalSpaceMicro,
                              Text(player.weight.toString(),
                                  style: AppTextStyles.infoTextStyle),
                              Text('kg', style: AppTextStyles.cautionTextStyle),
                            ],
                          ),
                          AppSpacesBox.verticalSpaceSmall,
                          Row(
                            children: [
                              Badge(
                                largeSize: 21,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSpaceSize.mediumSize),
                                label: Text(
                                  player.division_nm,
                                  style: AppTextStyles.descriptionTextStyle,
                                ),
                                backgroundColor: Pallete.primaryColor,
                              ),
                              AppSpacesBox.horizontalSpaceMicro,
                              Wrap(
                                spacing: AppSpaceSize.smallSize,
                                children: player.positions
                                    .map((position) => Badge(
                                          largeSize: 21,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppSpaceSize.mediumSize),
                                          label: Text(
                                            position,
                                            style: AppTextStyles
                                                .descriptionTextStyle,
                                          ),
                                          backgroundColor:
                                              Pallete.seconderyColor,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpacesBox.verticalSpaceMedium,
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.bookmark_border,
                  color: Pallete.primaryColor),
              onPressed: () {
                // 북마크 버튼 클릭 이벤트 처리
              },
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Pallete.primaryColor),
              onPressed: () {
                // 여기에서 player의 id를 이용하여 라우트 경로를 구성합니다.
                Routemaster.of(context).push('/player/${player.user_id}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
