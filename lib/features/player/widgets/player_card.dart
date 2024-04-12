import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/common/widgets/image/common_circle_image_view.dart';
import '../../../core/common/controllers/CommCodeController.dart';
import '../models/player_model.dart';

class PlayerCard extends ConsumerWidget {
  const PlayerCard({
    super.key,
    required this.player,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    return GestureDetector(
      onTap: () {
        // 여기에서 player의 id를 이용하여 라우트 경로를 구성합니다.
        Routemaster.of(context).push('/player/${player.user_id}');
      },
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonCircleImageView(
                        profileImage: player.profile_image,
                        radius: 25,
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
                                Text(player.weight.toString(),
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
                            AppSpacesBox.verticalSpaceMicro,
                            Row(
                              children: [
                                Badge(
                                  largeSize: 21,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSpaceSize.mediumSize),
                                  label: Text(
                                    player.division_nm,
                                    style: AppTextStyles.descriptionTextStyle
                                        .copyWith(
                                      color: Pallete.greyColor,
                                    ),
                                  ),
                                  backgroundColor:
                                      Pallete.primaryColor.withOpacity(0.2),
                                ),
                                AppSpacesBox.horizontalSpaceMicro,
                                Wrap(
                                  spacing: AppSpaceSize.smallSize,
                                  children: player.positions
                                      .map(
                                        (position) => Badge(
                                          largeSize: 20,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppSpaceSize.smallSize),
                                          label: Text(
                                            position,
                                            style: AppTextStyles
                                                .descriptionTextStyle
                                                .copyWith(
                                                    color: Pallete.greyColor),
                                          ),
                                          backgroundColor: Pallete.greyColor
                                              .withOpacity(0.1),
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
        ],
      ),
    );
  }
}
