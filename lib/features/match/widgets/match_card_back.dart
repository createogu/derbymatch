import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../models/match_model.dart';

class MatchCardBack extends ConsumerWidget {
  const MatchCardBack({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push('/match/${match.match_id}');
      },
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Row(
              children: [
                Text('${match.start_time} ~ ${match.end_time}',
                    style: AppTextStyles.bodyTextStyle),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                          'matchStatus', match.match_status) ??
                                      '정보없음',
                                  style: AppTextStyles.cautionTextStyle
                                      .copyWith(color: Pallete.greyColor),
                                ),
                                backgroundColor:
                                    Pallete.blueColor.withOpacity(0.2),
                              ),
                              AppSpacesBox.horizontalSpaceMicro,
                              Badge(
                                largeSize: 20,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSpaceSize.mediumSize),
                                label: Text(
                                  CommCodeController.getCommCodeName(
                                          'matchType', match.match_type) ??
                                      '정보없음',
                                  style: AppTextStyles.cautionTextStyle
                                      .copyWith(color: Pallete.greyColor),
                                ),
                                backgroundColor:
                                    Pallete.blueColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                          AppSpacesBox.verticalSpaceMicro,
                          Row(
                            children: [
                              Text(
                                match.court_name,
                                style: AppTextStyles.bodyTextStyle,
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
          ],
        ),
      ),
    );
  }
}
