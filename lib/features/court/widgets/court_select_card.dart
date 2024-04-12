import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../models/court_model.dart';

class CourtSelectCard extends ConsumerWidget {
  const CourtSelectCard({
    super.key,
    required this.court,
  });

  final CourtModel court;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    return Container(
      child: Column(
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
                                    'courtTypeDetail',
                                    court.court_type_detail) ??
                                '정보없음',
                            style: AppTextStyles.cautionTextStyle
                                .copyWith(color: Pallete.greyColor),
                          ),
                          backgroundColor: Pallete.blueColor.withOpacity(0.2),
                        ),
                      ],
                    ),
                    AppSpacesBox.verticalSpaceMicro,
                    Row(
                      children: [
                        Text(court.court_name,
                            style: AppTextStyles.bodyTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          court.road_address,
                          style: AppTextStyles.descriptionTextStyle.copyWith(
                            color: Pallete.greyColor.withOpacity(0.5),
                          ),
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
    );
  }
}
