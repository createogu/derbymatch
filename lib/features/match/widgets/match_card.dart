import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../models/match_model.dart';

class MatchCard extends ConsumerWidget {
  const MatchCard({
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${match.start_time}',
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '세종특별시',
                      style: AppTextStyles.cautionTextStyle
                          .copyWith(color: Pallete.greyColor),
                    ),
                    Text(
                      match.court_name,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                    Text(
                      CommCodeController.getCommCodeName(
                              'matchType', match.match_type) ??
                          '정보없음',
                      style: AppTextStyles.cautionTextStyle
                          .copyWith(color: Pallete.greyColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Badge(
                  largeSize: 20,
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
                  label: Text(
                    CommCodeController.getCommCodeName(
                            'matchStatus', match.match_status) ??
                        '정보없음',
                    style: AppTextStyles.cautionTextStyle
                        .copyWith(color: Pallete.greyColor),
                  ),
                  backgroundColor: Pallete.blueColor.withOpacity(0.2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
